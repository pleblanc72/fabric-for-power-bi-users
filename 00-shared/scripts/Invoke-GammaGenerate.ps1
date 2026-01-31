<#
.SYNOPSIS
    Generate Gamma presentations from markdown files using the Gamma API.

.DESCRIPTION
    This script reads a slides-gamma.md file and sends it to the Gamma API
    to auto-generate a presentation. It uses --- breaks for slide separation.

.PARAMETER InputFile
    Path to the markdown file (slides-gamma.md)

.PARAMETER ConfigFile
    Path to the config JSON file. Defaults to gamma-config.json in the same folder as this script.

.PARAMETER ApiKey
    Gamma API key. Overrides config file if provided.

.PARAMETER ThemeId
    Gamma theme ID. Overrides config file if provided.

.PARAMETER ExportAs
    Export format: 'pdf', 'pptx', or 'none'. Defaults to config file setting.

.PARAMETER OutputFolder
    Folder to save exported files. Defaults to same folder as input file.

.PARAMETER WaitForCompletion
    If specified, waits for generation to complete and downloads the export.

.PARAMETER NumCards
    Override the number of cards (slides). If not specified, uses inputTextBreaks.

.PARAMETER Format
    Output format: 'presentation', 'document', 'webpage', 'social'. Defaults to 'presentation'.

.EXAMPLE
    .\Invoke-GammaGenerate.ps1 -InputFile ".\04-dataflows-pipelines\slides\slides-gamma.md"

.EXAMPLE
    .\Invoke-GammaGenerate.ps1 -InputFile ".\slides-gamma.md" -ApiKey "sk-gamma-xxx" -ThemeId "abc123" -WaitForCompletion

.EXAMPLE
    .\Invoke-GammaGenerate.ps1 -InputFile ".\slides-gamma.md" -ExportAs "pdf" -WaitForCompletion

.NOTES
    Author: Workshop Automation Script
    Requires: Gamma API key (Pro or Ultra plan)
    API Docs: https://developers.gamma.app/docs/getting-started
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$InputFile,

    [Parameter(Mandatory = $false)]
    [string]$ConfigFile,

    [Parameter(Mandatory = $false)]
    [string]$ApiKey,

    [Parameter(Mandatory = $false)]
    [string]$ThemeId,

    [Parameter(Mandatory = $false)]
    [ValidateSet('pdf', 'pptx', 'none')]
    [string]$ExportAs,

    [Parameter(Mandatory = $false)]
    [string]$OutputFolder,

    [Parameter(Mandatory = $false)]
    [switch]$WaitForCompletion,

    [Parameter(Mandatory = $false)]
    [ValidateRange(1, 75)]
    [int]$NumCards,

    [Parameter(Mandatory = $false)]
    [ValidateSet('presentation', 'document', 'webpage', 'social')]
    [string]$Format,

    [Parameter(Mandatory = $false)]
    [string]$AdditionalInstructions,

    [Parameter(Mandatory = $false)]
    [ValidateSet('generate', 'condense', 'preserve')]
    [string]$TextMode,

    [Parameter(Mandatory = $false)]
    [ValidateSet('auto', 'inputTextBreaks')]
    [string]$CardSplit,

    [Parameter(Mandatory = $false)]
    [ValidateSet('aiGenerated', 'unsplash', 'webFreeToUse', 'noImages', 'placeholder')]
    [string]$ImageSource,

    [Parameter(Mandatory = $false)]
    [string]$ImageStyle,

    [Parameter(Mandatory = $false)]
    [int]$PollIntervalSeconds = 5,

    [Parameter(Mandatory = $false)]
    [int]$MaxWaitSeconds = 300
)

# ============================================================================
# CONFIGURATION
# ============================================================================

$ErrorActionPreference = "Stop"
$BaseApiUrl = "https://public-api.gamma.app/v1.0"

# Determine config file path
if (-not $ConfigFile) {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $ConfigFile = Join-Path $ScriptDir "gamma-config.json"
}

# Load configuration
$Config = $null
if (Test-Path $ConfigFile) {
    Write-Host "Loading config from: $ConfigFile" -ForegroundColor Cyan
    $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
} else {
    Write-Warning "Config file not found at: $ConfigFile"
    Write-Warning "Using command-line parameters only."
}

# Resolve API Key
$ResolvedApiKey = if ($ApiKey) { $ApiKey } elseif ($Config.apiKey) { $Config.apiKey } else { $null }
if (-not $ResolvedApiKey -or $ResolvedApiKey -eq "sk-gamma-YOUR_API_KEY_HERE") {
    Write-Error "API Key is required. Provide via -ApiKey parameter or in gamma-config.json"
    exit 1
}

# Resolve Theme ID
$ResolvedThemeId = if ($ThemeId) { $ThemeId } elseif ($Config.themeId -and $Config.themeId -ne "YOUR_THEME_ID_HERE") { $Config.themeId } else { $null }

# Resolve other settings with fallbacks
$DefaultSettings = $Config.defaultSettings
$ResolvedFormat = if ($Format) { $Format } elseif ($DefaultSettings.format) { $DefaultSettings.format } else { "presentation" }
$ResolvedTextMode = if ($TextMode) { $TextMode } elseif ($DefaultSettings.textMode) { $DefaultSettings.textMode } else { "preserve" }
$ResolvedCardSplit = if ($CardSplit) { $CardSplit } elseif ($DefaultSettings.cardSplit) { $DefaultSettings.cardSplit } else { "inputTextBreaks" }
$ResolvedExportAs = if ($ExportAs) { $ExportAs } elseif ($DefaultSettings.exportAs) { $DefaultSettings.exportAs } else { "pptx" }
$ResolvedAdditionalInstructions = if ($AdditionalInstructions) { $AdditionalInstructions } elseif ($DefaultSettings.additionalInstructions) { $DefaultSettings.additionalInstructions } else { "" }

# Resolve output folder
$InputFileInfo = Get-Item $InputFile
$ResolvedOutputFolder = if ($OutputFolder) { $OutputFolder } else { $InputFileInfo.DirectoryName }

# ============================================================================
# FUNCTIONS
# ============================================================================

function Read-MarkdownContent {
    param([string]$FilePath)
    
    $Content = Get-Content $FilePath -Raw -Encoding UTF8
    
    # Normalize line endings to Unix-style (LF) - Gamma API expects \n---\n
    $Content = $Content -replace "`r`n", "`n"
    
    # Count slides (--- separators)
    $SlideBreaks = ([regex]::Matches($Content, '\n---\n')).Count
    $SlideCount = $SlideBreaks + 1
    
    Write-Host "Markdown file: $FilePath" -ForegroundColor Green
    Write-Host "Detected slides: $SlideCount" -ForegroundColor Green
    Write-Host "Character count: $($Content.Length)" -ForegroundColor Green
    
    return @{
        Content = $Content
        SlideCount = $SlideCount
    }
}

function Build-RequestBody {
    param(
        [string]$InputText,
        [hashtable]$Options
    )
    
    $Body = @{
        inputText = $InputText
        textMode = $Options.TextMode
        format = $Options.Format
        cardSplit = $Options.CardSplit
    }
    
    # Add theme if specified
    if ($Options.ThemeId) {
        $Body.themeId = $Options.ThemeId
    }
    
    # Add export format if not 'none'
    if ($Options.ExportAs -and $Options.ExportAs -ne 'none') {
        $Body.exportAs = $Options.ExportAs
    }
    
    # Add numCards if using auto split
    if ($Options.CardSplit -eq 'auto' -and $Options.NumCards) {
        $Body.numCards = $Options.NumCards
    }
    
    # Add additional instructions
    if ($Options.AdditionalInstructions) {
        $Body.additionalInstructions = $Options.AdditionalInstructions
    }
    
    # Add text options if available
    if ($DefaultSettings.textOptions) {
        $Body.textOptions = @{}
        if ($DefaultSettings.textOptions.amount) { $Body.textOptions.amount = $DefaultSettings.textOptions.amount }
        if ($DefaultSettings.textOptions.tone) { $Body.textOptions.tone = $DefaultSettings.textOptions.tone }
        if ($DefaultSettings.textOptions.audience) { $Body.textOptions.audience = $DefaultSettings.textOptions.audience }
        if ($DefaultSettings.textOptions.language) { $Body.textOptions.language = $DefaultSettings.textOptions.language }
    }
    
    # Add image options
    $ImageSourceResolved = if ($ImageSource) { $ImageSource } elseif ($DefaultSettings.imageOptions.source) { $DefaultSettings.imageOptions.source } else { "aiGenerated" }
    $ImageStyleResolved = if ($ImageStyle) { $ImageStyle } elseif ($DefaultSettings.imageOptions.style) { $DefaultSettings.imageOptions.style } else { $null }
    
    $Body.imageOptions = @{
        source = $ImageSourceResolved
    }
    if ($ImageStyleResolved -and $ImageSourceResolved -eq "aiGenerated") {
        $Body.imageOptions.style = $ImageStyleResolved
    }
    
    # Add card options
    if ($DefaultSettings.cardOptions) {
        $Body.cardOptions = @{}
        if ($DefaultSettings.cardOptions.dimensions) {
            $Body.cardOptions.dimensions = $DefaultSettings.cardOptions.dimensions
        }
    }
    
    return $Body
}

function Invoke-GammaGenerate {
    param(
        [hashtable]$Body,
        [string]$ApiKey
    )
    
    $Headers = @{
        "Content-Type" = "application/json"
        "X-API-KEY" = $ApiKey
        "Accept" = "application/json"
    }
    
    $JsonBody = $Body | ConvertTo-Json -Depth 10
    
    Write-Host "`nSending request to Gamma API..." -ForegroundColor Yellow
    Write-Verbose "Request body: $JsonBody"
    
    try {
        $Response = Invoke-RestMethod -Uri "$BaseApiUrl/generations" -Method Post -Headers $Headers -Body $JsonBody
        return $Response
    }
    catch {
        $ErrorMessage = $_.Exception.Message
        if ($_.Exception.Response) {
            $Reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $ErrorBody = $Reader.ReadToEnd()
            Write-Error "API Error: $ErrorMessage`nResponse: $ErrorBody"
        }
        else {
            Write-Error "API Error: $ErrorMessage"
        }
        throw
    }
}

function Get-GenerationStatus {
    param(
        [string]$GenerationId,
        [string]$ApiKey
    )
    
    $Headers = @{
        "X-API-KEY" = $ApiKey
        "Accept" = "application/json"
    }
    
    try {
        $Response = Invoke-RestMethod -Uri "$BaseApiUrl/generations/$GenerationId" -Method Get -Headers $Headers
        return $Response
    }
    catch {
        Write-Error "Failed to get generation status: $($_.Exception.Message)"
        throw
    }
}

function Wait-ForGeneration {
    param(
        [string]$GenerationId,
        [string]$ApiKey,
        [int]$PollInterval,
        [int]$MaxWait
    )
    
    $Elapsed = 0
    $Status = $null
    
    Write-Host "`nWaiting for generation to complete..." -ForegroundColor Yellow
    
    while ($Elapsed -lt $MaxWait) {
        $Status = Get-GenerationStatus -GenerationId $GenerationId -ApiKey $ApiKey
        
        Write-Host "  Status: $($Status.status) (${Elapsed}s elapsed)" -ForegroundColor Gray
        
        if ($Status.status -eq "completed") {
            Write-Host "Generation completed!" -ForegroundColor Green
            return $Status
        }
        elseif ($Status.status -eq "failed") {
            Write-Error "Generation failed: $($Status.error)"
            return $Status
        }
        
        Start-Sleep -Seconds $PollInterval
        $Elapsed += $PollInterval
    }
    
    Write-Warning "Timed out waiting for generation after ${MaxWait}s"
    return $Status
}

function Save-ExportedFile {
    param(
        [string]$Url,
        [string]$OutputPath
    )
    
    Write-Host "Downloading export to: $OutputPath" -ForegroundColor Cyan
    
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath
        Write-Host "File saved successfully!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Warning "Failed to download file: $($_.Exception.Message)"
        return $false
    }
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "  GAMMA PRESENTATION GENERATOR" -ForegroundColor Magenta
Write-Host "========================================`n" -ForegroundColor Magenta

# Read markdown content
$MarkdownData = Read-MarkdownContent -FilePath $InputFile

# Build request options
$RequestOptions = @{
    TextMode = $ResolvedTextMode
    Format = $ResolvedFormat
    CardSplit = $ResolvedCardSplit
    ExportAs = $ResolvedExportAs
    ThemeId = $ResolvedThemeId
    NumCards = $NumCards
    AdditionalInstructions = $ResolvedAdditionalInstructions
}

Write-Host "`nGeneration Settings:" -ForegroundColor Cyan
Write-Host "  Format: $ResolvedFormat"
Write-Host "  Text Mode: $ResolvedTextMode"
Write-Host "  Card Split: $ResolvedCardSplit"
Write-Host "  Export As: $ResolvedExportAs"
Write-Host "  Theme ID: $(if ($ResolvedThemeId) { $ResolvedThemeId } else { '(default)' })"

# Build request body
$RequestBody = Build-RequestBody -InputText $MarkdownData.Content -Options $RequestOptions

# Send to Gamma API
$GenerateResponse = Invoke-GammaGenerate -Body $RequestBody -ApiKey $ResolvedApiKey

if (-not $GenerateResponse.generationId) {
    Write-Error "No generation ID returned from API"
    exit 1
}

$GenerationId = $GenerateResponse.generationId
Write-Host "`nGeneration started!" -ForegroundColor Green
Write-Host "  Generation ID: $GenerationId" -ForegroundColor Cyan

# Wait for completion if requested
if ($WaitForCompletion) {
    $FinalStatus = Wait-ForGeneration -GenerationId $GenerationId -ApiKey $ResolvedApiKey -PollInterval $PollIntervalSeconds -MaxWait $MaxWaitSeconds
    
    if ($FinalStatus.status -eq "completed") {
        Write-Host "`n========================================" -ForegroundColor Green
        Write-Host "  GENERATION COMPLETE" -ForegroundColor Green
        Write-Host "========================================`n" -ForegroundColor Green
        
        # Display results
        if ($FinalStatus.url) {
            Write-Host "Gamma URL: $($FinalStatus.url)" -ForegroundColor Cyan
        }
        if ($FinalStatus.gammaUrl) {
            Write-Host "Gamma URL: $($FinalStatus.gammaUrl)" -ForegroundColor Cyan
        }
        
        # Display credits info
        if ($FinalStatus.credits) {
            Write-Host "`nCredits:" -ForegroundColor Yellow
            Write-Host "  Used: $($FinalStatus.credits.deducted)" -ForegroundColor White
            Write-Host "  Remaining: $($FinalStatus.credits.remaining)" -ForegroundColor White
        }
        
        # Download export if available
        $ExportUrl = if ($FinalStatus.exportUrl) { $FinalStatus.exportUrl } else { $null }
        if ($ExportUrl -and $ResolvedExportAs -ne 'none') {
            # Get the section folder name (e.g., "04-dataflows-pipelines" from "..\04-dataflows-pipelines\slides\slides-gamma.md")
            $FullInputPath = (Resolve-Path $InputFile).Path
            $SlidesFolder = Split-Path -Parent $FullInputPath          # ..\04-dataflows-pipelines\slides
            $SectionFolder = Split-Path -Parent $SlidesFolder          # ..\04-dataflows-pipelines
            $SectionName = Split-Path -Leaf $SectionFolder             # 04-dataflows-pipelines
            
            $ExportFileName = "$SectionName.$ResolvedExportAs"
            $ExportPath = Join-Path $SlidesFolder $ExportFileName      # Save next to slides-gamma.md
            
            Save-ExportedFile -Url $ExportUrl -OutputPath $ExportPath
        }
        
        # Log credits to tracker file
        if ($FinalStatus.credits) {
            $TrackerPath = Join-Path $ScriptDir "gamma-credits.md"
            if (Test-Path $TrackerPath) {
                $FullInputPath = (Resolve-Path $InputFile).Path
                $SlidesFolder = Split-Path -Parent $FullInputPath
                $SectionFolder = Split-Path -Parent $SlidesFolder
                $SectionName = Split-Path -Leaf $SectionFolder
                $Timestamp = Get-Date -Format "yyyy-MM-dd"
                $Time = Get-Date -Format "HH:mm"
                $SlideCount = $MarkdownData.SlideCount
                $CreditsUsed = $FinalStatus.credits.deducted
                $CreditsRemaining = $FinalStatus.credits.remaining
                
                # Read current content
                $TrackerContent = Get-Content $TrackerPath -Raw
                
                # Update the current balance line
                $TrackerContent = $TrackerContent -replace "## Current Balance: \d+ credits", "## Current Balance: $CreditsRemaining credits"
                
                # Find the table and add new row
                $NewRow = "| $Timestamp | $Time | $SectionName | $SlideCount | $CreditsUsed | $CreditsRemaining |"
                $TrackerContent = $TrackerContent -replace "(\| Date \| Time \| Section \| Slides \| Credits Used \| Remaining \|`n\|[^\n]+\|)", "`$1`n$NewRow"
                
                # Update last updated date
                $TrackerContent = $TrackerContent -replace "\*Last updated: [^\*]+\*", "*Last updated: $Timestamp $Time*"
                
                # Write back
                Set-Content -Path $TrackerPath -Value $TrackerContent -Encoding UTF8
                Write-Host "`nCredits logged to: $TrackerPath" -ForegroundColor Gray
            }
        }
        
        # Return result object
        return @{
            Success = $true
            GenerationId = $GenerationId
            Url = if ($FinalStatus.gammaUrl) { $FinalStatus.gammaUrl } else { $FinalStatus.url }
            ExportUrl = $ExportUrl
            Status = $FinalStatus.status
            CreditsUsed = if ($FinalStatus.credits) { $FinalStatus.credits.deducted } else { $null }
            CreditsRemaining = if ($FinalStatus.credits) { $FinalStatus.credits.remaining } else { $null }
        }
    }
    else {
        Write-Warning "Generation did not complete successfully"
        return @{
            Success = $false
            GenerationId = $GenerationId
            Status = $FinalStatus.status
            Error = $FinalStatus.error
        }
    }
}
else {
    # Not waiting - provide instructions
    Write-Host "`nGeneration is running in the background." -ForegroundColor Yellow
    Write-Host "Check status with:" -ForegroundColor Gray
    Write-Host "  .\Invoke-GammaGenerate.ps1 -CheckStatus -GenerationId $GenerationId" -ForegroundColor White
    Write-Host "`nOr visit: https://gamma.app/generate" -ForegroundColor Gray
    
    return @{
        Success = $true
        GenerationId = $GenerationId
        Status = "pending"
    }
}
