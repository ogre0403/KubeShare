# call from repo root

FROM ubuntu:18.04 AS build

ENV GOLANG_VERSION 1.13.5
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR /tmp

RUN apt update && \
    apt install -y g++ wget make git && \
    wget -nv -O - https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz && \
    git clone https://github.com/ogre0403/KubeShare.git

RUN cd KubeShare && make kubeshare-scheduler



FROM alpine:3.9

COPY --from=build /tmp/KubeShare/bin/kubeshare-scheduler /usr/bin/kubeshare-scheduler

CMD ["kubeshare-scheduler", "-alsologtostderr", "-v=4"]


# docker cp . nifty_maxwell:/go

# export GOLANG_VERSION=1.13.5
# export GOPATH=/go
# export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
# mkdir -p /go/src/KubeShare
# cd /go/src/KubeShare
