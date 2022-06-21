## dotfiles

My pc config :)

### vim-docker

```sh
podman build . -t sofdg2/vim-docker:latest --no-cache
cd ~/projects/dotfiles
podman-compose run --service-ports vim-docker
```
