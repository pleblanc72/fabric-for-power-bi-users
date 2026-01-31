# Gamma API Integration for Workshop Slides

This folder contains scripts to auto-generate Gamma presentations from your `slides-gamma.md` files.

## Quick Start

1. **Get your Gamma API key** from [developers.gamma.app](https://developers.gamma.app/docs/get-access)
2. **Get your Theme ID** from Gamma (see instructions below)
3. **Update the config file** with your credentials
4. **Run the script**

## Setup

### 1. Configure Your Credentials

Edit `gamma-config.json`:

```json
{
  "apiKey": "sk-gamma-YOUR_ACTUAL_KEY",
  "themeId": "YOUR_ACTUAL_THEME_ID",
  ...
}
```

### 2. Find Your Theme ID

**Option A: From the Gamma App**
1. Open any presentation in Gamma
2. Click the theme selector
3. The URL will contain the theme ID, or
4. Use browser dev tools to inspect the theme element

**Option B: Via API**
```powershell
# List all themes in your workspace
$headers = @{ "X-API-KEY" = "sk-gamma-YOUR_KEY" }
Invoke-RestMethod -Uri "https://public-api.gamma.app/v1.0/themes" -Headers $headers | ConvertTo-Json
```

## Usage

### Basic Usage

```powershell
# Navigate to the scripts folder
cd "c:\vscode\Workshops\Fabric for the Powr BI Users\00-shared\scripts"

# Generate a presentation (async - returns immediately)
.\Invoke-GammaGenerate.ps1 -InputFile "..\..\04-dataflows-pipelines\slides\slides-gamma.md"

# Generate and wait for completion (downloads the PPTX)
.\Invoke-GammaGenerate.ps1 -InputFile "..\..\04-dataflows-pipelines\slides\slides-gamma.md" -WaitForCompletion
```

### Override Settings

```powershell
# Use a different theme
.\Invoke-GammaGenerate.ps1 -InputFile ".\slides.md" -ThemeId "abc123def" -WaitForCompletion

# Export to PDF instead of PPTX
.\Invoke-GammaGenerate.ps1 -InputFile ".\slides.md" -ExportAs "pdf" -WaitForCompletion

# No AI images (use placeholders)
.\Invoke-GammaGenerate.ps1 -InputFile ".\slides.md" -ImageSource "placeholder" -WaitForCompletion

# Override all settings inline
.\Invoke-GammaGenerate.ps1 -InputFile ".\slides.md" `
    -ApiKey "sk-gamma-xxx" `
    -ThemeId "mytheme123" `
    -ExportAs "pptx" `
    -ImageSource "aiGenerated" `
    -ImageStyle "minimal, professional" `
    -WaitForCompletion
```

### Generate All Section Slides

```powershell
# Batch generate all sections
$sections = @(
    "01-why-fabric\slides\slides-gamma.md",
    "02-cicd-git-integration\slides\slides-gamma.md",
    "03-data-centralization\slides\slides-gamma.md",
    "04-dataflows-pipelines\slides\slides-gamma.md"
)

foreach ($section in $sections) {
    $path = Join-Path "c:\vscode\Workshops\Fabric for the Powr BI Users" $section
    if (Test-Path $path) {
        Write-Host "Generating: $section" -ForegroundColor Cyan
        .\Invoke-GammaGenerate.ps1 -InputFile $path -WaitForCompletion
    }
}
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `-InputFile` | Yes | Path to the slides-gamma.md file |
| `-ConfigFile` | No | Path to config JSON (default: gamma-config.json) |
| `-ApiKey` | No | Overrides config file API key |
| `-ThemeId` | No | Overrides config file theme ID |
| `-ExportAs` | No | `pdf`, `pptx`, or `none` |
| `-WaitForCompletion` | No | Wait and download the export |
| `-Format` | No | `presentation`, `document`, `webpage`, `social` |
| `-TextMode` | No | `preserve`, `generate`, `condense` |
| `-CardSplit` | No | `inputTextBreaks` (uses ---) or `auto` |
| `-ImageSource` | No | `aiGenerated`, `unsplash`, `noImages`, `placeholder` |
| `-ImageStyle` | No | Style for AI images (e.g., "minimal, tech") |
| `-NumCards` | No | Override slide count (only with `auto` split) |
| `-AdditionalInstructions` | No | Extra instructions for Gamma AI |
| `-PollIntervalSeconds` | No | Check interval when waiting (default: 5) |
| `-MaxWaitSeconds` | No | Max wait time (default: 300) |

## Config File Reference

```json
{
  "apiKey": "sk-gamma-xxx",           // Required: Your Gamma API key
  "themeId": "abc123",                // Optional: Default theme ID
  "defaultSettings": {
    "format": "presentation",         // Output type
    "textMode": "preserve",           // Keep your text exactly
    "cardSplit": "inputTextBreaks",   // Use --- for slides
    "exportAs": "pptx",               // Export format
    "additionalInstructions": "...",  // AI guidance
    "textOptions": {
      "amount": "medium",             // Text density
      "tone": "professional",         // Writing tone
      "audience": "Power BI users"    // Target audience
    },
    "imageOptions": {
      "source": "aiGenerated",        // Image source
      "style": "minimal, professional" // Image style
    },
    "cardOptions": {
      "dimensions": "16x9"            // Slide aspect ratio
    }
  }
}
```

## Slide Markdown Format

The script expects your markdown to use `---` to separate slides:

```markdown
# Section Title

## Slide 1: Introduction

Content here...

---

## Slide 2: Key Points

More content...

---

## Slide 3: Summary

Final content...
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "API Key is required" | Add your key to gamma-config.json or use -ApiKey |
| "Unauthorized" | Check your API key is valid and has credits |
| Theme not applied | Verify theme ID exists in your workspace |
| Slides not splitting | Ensure `---` is on its own line with blank lines before/after |
| Export not downloading | Check the exportUrl - links expire after some time |

## API Credits

Gamma API uses credits per generation. Check your usage at [gamma.app/settings](https://gamma.app/settings).

## Links

- [Gamma API Docs](https://developers.gamma.app/docs/getting-started)
- [API Parameters Reference](https://developers.gamma.app/docs/generate-api-parameters-explained)
- [Get API Access](https://developers.gamma.app/docs/get-access)
