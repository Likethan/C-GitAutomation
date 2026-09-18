param(
    [Parameter(Mandatory = $true)]
    [string]$RepositoryPath,
    [string]$Message = "chore: automated activity update"
)
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
Set-Location $RepositoryPath
if (-not (Test-Path ".git")) { throw "Not a Git repository: $RepositoryPath" }
git add .
$status = git status --porcelain
if (-not $status) { Write-Host "No changes to commit."; exit 0 }
git commit -m $Message
git push origin HEAD
Write-Host "Automation commit pushed successfully."
