## dotfiles

My pc config :)

### vim-docker

Build:

```sh
podman build . -t sofdg2/vim-docker:latest
```

Login:

```sh
podman login docker.io
```

Push:

```sh
podman push sofdg2/vim-docker:latest
```

Run:

```
podman-compose run vim-docker
```
