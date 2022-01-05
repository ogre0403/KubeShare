# call from repo root

FROM nvidia/cuda:10.0-devel AS build

WORKDIR /tmp/build

RUN apt update && \
    apt install -y git libglib2.0-dev libzmq3-dev && \
    git clone https://github.com/ogre0403/Gemini.git && cd Gemini && \
    git checkout v1.0 && \
    make -C src

# FROM busybox:1.31.1-glibc
FROM alpine:3.9

COPY --from=build /tmp/build/Gemini/lib/libgemhook.so.1 /libgemhook.so.1

CMD ["cp", "/libgemhook.so.1", "/kubeshare/library/libgemhook.so.1"]
