FROM balenalib/jetson-nano-ubuntu:bionic

RUN apt-get update && apt-get install -y cuda-samples-10-0 cuda-toolkit-10-0 lbzip2

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y xorg

RUN \
    export SMS=53 && \
    cd /usr/local/cuda-10.0/samples/0_Simple/clock/ && make -j8 && \
    cd /usr/local/cuda-10.0/samples/1_Utilities/deviceQuery/ && make -j8 && \
    cd /usr/local/cuda-10.0/samples/2_Graphics/simpleTexture3D/ && make -j8 && \
    cd /usr/local/cuda-10.0/samples/2_Graphics/simpleGL/ && make -j8 && \
    cd /usr/local/cuda-10.0/samples/3_Imaging/postProcessGL/ && make -j8 && \
    cd /usr/local/cuda-10.0/samples/5_Simulations/smokeParticles && make -j8

ENV UDEV=1

WORKDIR /usr/local/cuda-10.0/samples/bin/aarch64/linux/release

CMD [ "sleep", "infinity" ]
