param (
[string]$repo = $(throw "Repo param in the format owner/repo is required. e.g. github/actions"),
[string]$gitHubPersonalAccessToken = $( Read-Host -asSecureString "Enter GitHub Personal Access Token" )
)

$runnerToken = (Invoke-WebRequest -Headers @{ "Accept" = "application/vnd.github.everest-preview+json";"Authorization" = "Token $gitHubPersonalAccessToken" } -Method POST -Uri "https://api.github.com/repos/$repo/actions/runners/registration-token" |
ConvertFrom-Json |
Select token).token
Set-Content -Path actions.env -Value "REPO_URL=https://github.com/$repo`r`nRUNNER_TOKEN=$runnerToken" -Force