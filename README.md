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

For arm32
```sh
podman-compose -f docker-compose-armv7.yml run vim-docker
```

For amd64
```sh
podman-compose -f docker-compose-amd64.yml run vim-docker
```

