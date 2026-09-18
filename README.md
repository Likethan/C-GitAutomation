# C-GitAutomation

A small PowerShell + GitHub Actions automation system for maintaining legitimate repository activity.

## Structure

- `scripts/auto_push.ps1` — local automation entry point.
- `scripts/commit_engine.ps1` — stages, commits, and pushes real changes.
- `scripts/activity_logger.ps1` — records automation runs.
- `config/repositories.json` — repository configuration.
- `config/commit_messages.json` — reusable commit messages.
- `data/activity.json` — cumulative automation state.
- `data/last_run.json` — latest run metadata.
- `logs/automation.log` — append-only activity log.
- `.github/workflows/automation-heartbeat.yml` — scheduled GitHub Actions heartbeat.

## How it works

The scheduled workflow updates the automation state files and log every 30 minutes. If those files changed, GitHub Actions creates a normal commit and pushes it to the default branch.

The local PowerShell runner processes enabled repositories from `config/repositories.json` and only creates a commit when there are actual working-tree changes.

The system is designed around actual file changes rather than empty commits or rewritten/backdated history.

## Local usage

```powershell
.\scripts\auto_push.ps1
```

Or run the commit engine directly:

```powershell
.\scripts\commit_engine.ps1 -RepositoryPath "C:\path\to\repository"
```

## Notes

- The workflow uses `contents: write` permission.
- Scheduled GitHub Actions runs can be delayed by GitHub's scheduler.
- The automation does not manufacture historical contributions.
