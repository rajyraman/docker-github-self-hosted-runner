if((Test-Path ".credentials") -eq $false)
{
    .\config.cmd --unattended --url $env:REPO_URL --token $env:RUNNER_TOKEN --name github-actions-runner-docker-$env:COMPUTERNAME;
}
.\run.cmd;