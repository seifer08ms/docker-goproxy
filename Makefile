IMAGE_NAME = seifer08ms/goproxy
CONTAINER_NAME = goproxy
HOST_PORT = 8087
EXPORT_CA_DIR = ${PWD}

default: build

all:     build install

debug : build run-debug

build:
	docker build -t ${IMAGE_NAME} .

pull:
	docker pull ${IMAGE_NAME}

push:
	docker push ${IMAGE_NAME}

shell:
	docker exec -it ${CONTAINER_NAME} /bin/bash

install:
	docker run  --name ${CONTAINER_NAME} -d --restart=always -p ${HOST_PORT}:8087 -v ${PWD}/gae.user.json:/goproxy/gae.user.json -v ${PWD}/httpproxy.user.json:/goproxy/httpproxy.user.json ${IMAGE_NAME}

crt :   
	docker cp ${CONTAINER_NAME}:/goproxy/GoProxy.crt  ${EXPORT_CA_DIR}

clean:     
	docker stop ${CONTAINER_NAME}
	docker rm ${CONTAINER_NAME}
purge:
	docker stop ${CONTAINER_NAME}
	docker rm ${CONTAINER_NAME}	    
	docker rmi ${IMAGE_NAME}

release: build push



