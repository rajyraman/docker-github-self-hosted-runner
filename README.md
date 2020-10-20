# docker-github-self-hosted-runner
 
## Build
```
docker build -t "githubrunner:latest" .
```

## Run
```
docker run -it  --name "githubrunner" -v "$pwd\actions-runner:c:\actions-runner:rw" --rm --env-file "actions.env" githubrunner:latest
```