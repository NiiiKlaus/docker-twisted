# Docker-twisted

## Features

- Minimal, built with latest official Alpine base image.
- Multi-arch, built upon all the architectures that the base image offers.
- SSL support, easy to work with self-signed certificates.

## Installation

```bash
$ docker pull niiiklaus/twisted:latest
```

## Usage

### Parameters

We always recommend you to use Docker containers in normal user for safety reason.

If you use HTTPS, the start script will look for `/certs/app.key` and `/certs/app.crt` by default. You can change the target file names using environment variables, but don't forget to map the volume where your certificate files stored to the container.

|         Parameter          |                           Function                           |
| :------------------------: | :----------------------------------------------------------: |
|   `-u $(id -u):$(id -g)`   |              User mapping (always recommended).              |
|       `-p 6080:6080`       |                          HTTP port.                          |
|       `-p 6443:6443`       | HTTPS port (listened if you map certificate files correctly). |
|   `-v /path/to/app:/app`   |         The directory where the web service starts.          |
| `-v /path/to/certs:/certs` |        The directory where certificate files stored.         |
|  `-e KEY_FILE=custom.key`  | The start script will look for `/certs/custom.key` instead of `/certs/app.key`. |
|  `-e CRT_FILE=custom.crt`  | The start script will look for `/certs/custom.crt` instead of `/certs/app.crt`. |

### Examples

#### One-time basic HTTP service

```bash
docker run -it --rm \
  -u $(id -u):$(id -g) \
  -p 6080:6080 \
  niiiklaus/twisted:latest
```

#### Constant HTTP service with HTTPS

Sometimes SSL raises an error due to time reasons, so read-only mapping `/etc/localtime` and `/etc/timezone` may be necessary.

```bash
docker run -itd \
  -u $(id -u):$(id -g) \
  -p 6080:6080 \
  -p 6443:6443 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v /path/to/app:/app \
  -v /path/to/certs:/certs:ro \
  -e KEY_FILE="KEY_FILE_NAME.key" \
  -e CRT_FILE="CRT_FILE_NAME.crt" \
  niiiklaus/twisted:latest
```



