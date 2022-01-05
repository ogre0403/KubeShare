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

RUN cd KubeShare && make kubeshare-config-client

FROM debian:stretch-slim

ENV NVIDIA_VISIBLE_DEVICES      all
ENV NVIDIA_DRIVER_CAPABILITIES  utility

COPY --from=build /tmp/KubeShare/bin/kubeshare-config-client /usr/bin/kubeshare-config-client

CMD ["kubeshare-config-client", "-alsologtostderr", "-server-ip=kubeshare-device-manager.kube-system.svc:9797", "-v=4"]
