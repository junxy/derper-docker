# Derper

[![docker workflow](https://github.com/junxy/derper-docker/actions/workflows/docker-image.yml/badge.svg)](https://hub.docker.com/r/junxy/derper)
[![Docker Image Size with architecture (latest by date/latest semver)](https://img.shields.io/docker/image-size/junxy/derper)](https://hub.docker.com/r/junxy/derper)
[![docker pulls](https://img.shields.io/docker/pulls/junxy/derper.svg?color=brightgreen)](https://hub.docker.com/r/junxy/derper)
[![platfrom](https://img.shields.io/badge/platform-amd64%20%7C%20arm64-brightgreen)](https://hub.docker.com/r/junxy/derper/tags)

Smaller image size achieved by using the Alpine base image.

Automatically updated on a weekly basis.

> forked from fredliang44/derper-docker

# Setup

> required: set env `DERP_DOMAIN` to your domain

```bash
docker run -e DERP_DOMAIN=derper.your-domain.com -p 80:80 -p 443:443 -p 3478:3478/udp junxy/derper
```

| env                 | required | description                                                            | default value     |
| ------------------- | -------- | ---------------------------------------------------------------------- | ----------------- |
| DERP_DOMAIN         | true     | derper server hostname                                                 | your-hostname.com |
| DERP_CERT_DIR       | false    | directory to store LetsEncrypt certs(if addr's port is :443)           | /app/certs        |
| DERP_CERT_MODE      | false    | mode for getting a cert. possible options: manual, letsencrypt         | letsencrypt       |
| DERP_ADDR           | false    | listening server address                                               | :443              |
| DERP_STUN           | false    | also run a STUN server                                                 | true              |
| DERP_STUN_PORT      | false    | The UDP port on which to serve STUN.                                   | 3478              |
| DERP_HTTP_PORT      | false    | The port on which to serve HTTP. Set to -1 to disable                  | 80                |
| DERP_VERIFY_CLIENTS | false    | verify clients to this DERP server through a local tailscaled instance | false             |

# Usage

Fully DERP setup offical documentation: https://tailscale.com/kb/1118/custom-derp-servers/
