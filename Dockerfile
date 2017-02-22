FROM ubuntu:16.04

ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

RUN apt-get -y update && apt-get install -y  curl tar xz-utils  # bzip2

ENV GOPROXY_VERSION linux_amd64-r1305

ADD resources /tmp/resources

# Downloading goproxy binary
RUN if [ ! -f  "/tmp/resources/goproxy_${GOPROXY_VERSION}.tar.xz" ];then \
 curl -kL https://github.com/phuslu/goproxy-ci/releases/download/r1305/goproxy_${GOPROXY_VERSION}.tar.xz | tar xvJ; \
else \
 cat /tmp/resources/goproxy_${GOPROXY_VERSION}.tar.xz |tar xvJ; \
fi;


# Commands when creating a new container
CMD ["/goproxy/goproxy"]
