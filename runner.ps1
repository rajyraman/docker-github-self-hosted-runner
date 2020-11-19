$version = (Invoke-WebRequest -Uri "https://api.github.com/repos/actions/runner/releases/latest" -UseBasicParsing |
ConvertFrom-Json |
Select tag_name).tag_name.SubString(1);

if((Test-Path "actions-runner-win-x64-$version.zip") -eq $false) {
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/actions/runner/releases/download/v$version/actions-runner-win-x64-$version.zip" -OutFile "actions-runner-win-x64-$version.zip";
    Expand-Archive -Path "actions-runner-win-x64-$version.zip"  -DestinationPath actions-runner -Force
}
if((Test-Path ".credentials") -eq $false)
{
    .\actions-runner\config.cmd --unattended --url $env:REPO_URL --token $env:RUNNER_TOKEN --name github-actions-runner-docker-$env:COMPUTERNAME;
}
.\actions-runner\run.cmd;