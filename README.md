## dotfiles

My pc config :)

### vim-docker

**Build for amd64**

```sh
podman build . -t sofdg2/vim-docker:latest
```

**Build for armv7**

```sh
podman build . -t sofdg2/vim-docker:armv7
```

**For amd64**

```sh
podman-compose -f docker-compose-amd64.yml run vim-docker
```

**Run on armv7**

```sh
podman-compose -f docker-compose-armv7.yml run vim-docker
```

**Build kops to armv7**

```sh
cd kops/cmd/kops/
env GOOS=linux GOARCH=arm GOARM=7 go build
```

**Login**

```sh
podman login docker.io
```

**Push for amd64**

```sh
podman push sofdg2/vim-docker:latest
```

**Push for armv7**

```sh
podman push sofdg2/vim-docker:armv7
```
