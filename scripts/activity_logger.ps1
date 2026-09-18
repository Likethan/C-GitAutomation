param(
    [Parameter(Mandatory = $true)]
    [string]$LogPath,
    [string]$Repository,
    [string]$Status = "completed"
)
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$directory = Split-Path -Parent $LogPath
if ($directory -and -not (Test-Path $directory)) { New-Item -ItemType Directory -Path $directory -Force | Out-Null }
$timestamp = (Get-Date).ToString("o")
"$timestamp | repository=$Repository | status=$Status" | Add-Content -Path $LogPath
