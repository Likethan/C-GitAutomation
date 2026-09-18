param(
    [string]$ConfigPath = "$PSScriptRoot\..\config\repositories.json"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path $ConfigPath)) {
    throw "Repository configuration not found: $ConfigPath"
}

$config = Get-Content $ConfigPath -Raw | ConvertFrom-Json

foreach ($repo in $config.repositories) {
    if (-not $repo.enabled) { continue }

    Write-Host "Processing $($repo.name)..."
    & "$PSScriptRoot\commit_engine.ps1" -RepositoryPath $repo.path -Message "chore: automated repository sync"

    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Automation failed for $($repo.name)."
    }
}
