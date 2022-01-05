# call from repo root

FROM nvidia/cuda:10.0-devel AS build

WORKDIR /tmp/build

COPY . kubeshare

RUN apt update && \
    apt install -y git libglib2.0-dev libzmq3-dev && \
    git clone https://github.com/ogre0403/Gemini.git && cd Gemini && \
    git checkout v1.0 && \
    make -C src

FROM python:3.8.1-buster

RUN pip3 install inotify

ENV NVIDIA_VISIBLE_DEVICES      all
ENV NVIDIA_DRIVER_CAPABILITIES  utility

COPY libdl.so.2             /lib
COPY libnvidia-ml.so.1      /lib
COPY launcher-multigpus.sh  /launcher-multigpus.sh
COPY launcher.py            /launcher.py

COPY --from=build /tmp/build/Gemini/bin/gem-schd /gem-schd
COPY --from=build /tmp/build/Gemini/bin/gem-pmgr /gem-pmgr

CMD ["/launcher-multigpus.sh", "/kubeshare/scheduler/config", "/kubeshare/scheduler/podmanagerport"]
