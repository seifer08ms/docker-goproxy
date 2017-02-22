# Docker-goproxy

## Build

Run the following code in the path of repository to build a docker image.

`docker build -t seifer08ms/goproxy . ` or just `make`

## Run

Using `docker run` command to create a container named `goproxy`.

```bash
IMAGE_NAME = seifer08ms/goproxy
CONTAINER_NAME = goproxy
HOST_PORT = 8087
docker run  --name ${CONTAINER_NAME} -d --restart=always -p ${HOST_PORT}:8087 -v ${PWD}/gae.user.json:/goproxy/gae.user.json -v ${PWD}/httpproxy.user.json:/goproxy/httpproxy.user.json ${IMAGE_NAME}```

## Remote access

The container exposed 8087 ports for config and connection. Using httpproxy.user.json to allow remote access to a container.

```json
{
"Default": {
"Address": "0.0.0.0:8087",
},
}
```
### Export CRT file for certificate

We can export the CA file into a target path in host. Typeing `make crt` to cp GoProxy.crt into current folder. We should import this crt file into our browser for https certificate.

### Access from host

We can connect the goproxy container with `http://127.0.0.1:8087`

### Access from other container

Using `docker run --link` to connect xx-net with other client container.

`docker run --name ${CONTAINER_NAME} --link ${GOPROXY_CONTAINER_NAME}:proxy_server -d --restart=always  ${IMAGE_NAME}`

In the client container, using `http://proxy_server:8087` to access goproxy service.



