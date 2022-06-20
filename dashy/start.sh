#!/bin/bash

podman run -d \
  -p 8080:80 \
  -v ~/projects/dotfiles/dashy/conf.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
