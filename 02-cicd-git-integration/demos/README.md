# Demos: CI/CD & Git Integration

## Demo 1: Connect Workspace to GitHub

### Setup Required
- Empty Fabric workspace
- GitHub account with empty repository
- GitHub Personal Access Token (PAT) with repo access
- Admin permissions on workspace

### About Personal Access Tokens (PAT)

Fabric requires a Personal Access Token to connect to GitHub. This is the recommended authentication method because:

| Aspect | Why It Matters |
|--------|----------------|
| **Fine-grained permissions** | You control exactly which repositories Fabric can access |
| **Revocable** | If compromised, revoke just the token—not your entire GitHub account |
| **Auditable** | Token usage appears in your GitHub security log |
| **Time-limited** | Set expiration dates for better security |

**Recommended**: Use **Fine-grained Personal Access Tokens** (newer, more secure) over Classic tokens.

**Required permissions for Fabric:**
- **Contents**: Read and write
- **Metadata**: Read-only (auto-selected)

### Demo Script

1. **Create a new repository in GitHub**
   - Go to github.com → New repository
   - Name: `fabric-workshop-demo`
   - Keep it empty (no README)

2. **Create a Personal Access Token**
   - GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens
   - Generate new token with Contents read/write permission
   - Copy and save the token securely

3. **Create a new Fabric workspace**
   - Go to app.fabric.microsoft.com
   - Create workspace: `Workshop-Git-Demo`

4. **Connect to Git**
   - Workspace settings → Git integration
   - Select GitHub
   - Enter your Personal Access Token when prompted
   - Select repository and branch
   - Connect

5. **Show the connection**
   - Notice the Git status indicators
   - Show that workspace is now "synced"

### Key Points to Highlight
- PAT gives fine-grained control over what Fabric can access
- One workspace = one branch
- Initial sync can take time for large workspaces
- Connection is at workspace level, not item level

---

## Demo 2: Make a Change, Commit, Deploy

### Setup Required
- Connected workspace from Demo 1
- Simple semantic model (create one or import)

### Demo Script

1. **Create a simple semantic model**
   - New → Semantic model
   - Connect to sample Lakehouse
   - Add a table

2. **Notice the "uncommitted changes" indicator**
   - Show the source control panel
   - See the new item

3. **Commit the change**
   - Write a commit message: "Add initial semantic model"
   - Commit

4. **View in GitHub**
   - Open the repository
   - Show the folder structure
   - Navigate to the .tmdl files
   - Show the human-readable format

5. **Make a modification**
   - Add a measure to the model
   - Show the diff in the source control panel
   - Commit with message: "Add Total Sales measure"

6. **View the diff in GitHub**
   - Show the commit history
   - Click into the commit
   - Show the TMDL diff

### Key Points to Highlight
- TMDL is human-readable (can review PRs!)
- Each commit has a clear diff
- Model definition is now in version control

---

## Demo 3: Rollback Scenario

### Setup Required
- Committed model from Demo 2

### Demo Script

1. **Intentionally break something**
   - Modify a measure to have an error
   - Or delete something important
   - Commit: "Oops, broke something"

2. **Realize the mistake**
   - Try to use the model
   - See the error

3. **Find the issue in Git history**
   - Go to GitHub
   - View commit history
   - Identify the bad commit

4. **Rollback option 1: Revert in GitHub**
   - Create a revert commit
   - Sync in Fabric

5. **Rollback option 2: Update from Git**
   - In Fabric, update from Git
   - Pull the reverted version

6. **Verify the fix**
   - Model works again

### Key Points to Highlight
- Git gives you a safety net
- Can always go back to a working state
- Commit messages matter!

---

## Demo Tips

- Have a backup workspace ready in case something goes wrong
- Pre-create the GitHub repo to save time
- Use a simple model (1-2 tables) to keep diffs readable
