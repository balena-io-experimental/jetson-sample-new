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

# Get drivers and install
RUN \
   wget https://developer.nvidia.com/embedded/L4T/r32_Release_v4.3/t210ref_release_aarch64/Tegra210_Linux_R32.4.3_aarch64.tbz2  > /dev/null 2>&1 && \
   tar xjf Tegra210_Linux_R32.4.3_aarch64.tbz2 && \
   tar xjf Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2 -C / && \
   tar xjf Linux_for_Tegra/nv_tegra/config.tbz2 -C / --exclude=etc/hosts --exclude=etc/hostname && \
   echo "/usr/lib/aarch64-linux-gnu/tegra" > /etc/ld.so.conf.d/nvidia-tegra.conf && \
   echo "/usr/local/cuda-10.0/targets/aarch64-linux/lib" > /etc/ld.so.conf.d/cuda-10-0.conf && \
   ldconfig && \
   rm -f Tegra210_Linux_R32.4.3_aarch64.tbz2 && \
   rm -rf /usr/src/app/Linux_for_Tegra

ENV UDEV=1

WORKDIR /usr/local/cuda-10.0/samples/bin/aarch64/linux/release

CMD [ "sleep", "infinity" ]
