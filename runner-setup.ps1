param (
[string]$version = "2.273.5",
[string]$repo = $(throw "Repo param is required. e.g. github/actions"),
[string]$gitHubPersonalAccessToken = $( Read-Host -asSecureString "Enter GitHub Personal Access Token" )
)

$runnerFolder = "actions-runner"

if((Test-Path $runnerFolder) -eq $false)
{
    mkdir $runnerFolder;
}

if((Test-Path "actions-runner-win-x64-$VERSION.zip") -eq $false) {
    Invoke-WebRequest -Uri "https://github.com/actions/runner/releases/download/v$VERSION/actions-runner-win-x64-$VERSION.zip" -OutFile "actions-runner-win-x64-$VERSION.zip";
    Expand-Archive -Path "actions-runner-win-x64-$VERSION.zip" -DestinationPath $runnerFolder -Force
}

$runnerToken = (Invoke-WebRequest -Headers @{ "Accept" = "application/vnd.github.everest-preview+json";"Authorization" = "Token $gitHubPersonalAccessToken" } -Method POST -Uri "https://api.github.com/repos/$repo/actions/runners/registration-token" |
ConvertFrom-Json |
Select token).token
Set-Content -Path actions.env -Value "REPO_URL=https://github.com/$repo`r`nRUNNER_TOKEN=$runnerToken" -Force