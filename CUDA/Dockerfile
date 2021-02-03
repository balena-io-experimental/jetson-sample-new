FROM balenalib/jetson-nano-ubuntu:bionic


# Don't prompt with any configuration questions
ENV DEBIAN_FRONTEND noninteractive

# Install CUDA, CUDA samples and some utilities
RUN \
    apt-get update && apt-get install -y cuda-toolkit-10-2 cuda-samples-10-2 \
    lbzip2 xorg wget tar python3 libegl1

# Build some (but not all) of the sample apps
RUN \
    export SMS=53 && \
    cd /usr/local/cuda-10.2/samples/0_Simple/clock/ && make -j8 && \
    cd /usr/local/cuda-10.2/samples/1_Utilities/deviceQuery/ && make -j8 && \
    cd /usr/local/cuda-10.2/samples/2_Graphics/simpleTexture3D/ && make -j8 && \
    cd /usr/local/cuda-10.2/samples/2_Graphics/simpleGL/ && make -j8 && \
    cd /usr/local/cuda-10.2/samples/3_Imaging/postProcessGL/ && make -j8 && \
    cd /usr/local/cuda-10.2/samples/5_Simulations/smokeParticles && make -j8

ENV UDEV=1

# Download and install BSP binaries for L4T 32.4.4
RUN apt-get update && apt-get install -y wget tar lbzip2 python3 libegl1 && \
    wget https://developer.nvidia.com/embedded/L4T/r32_Release_v4.4/r32_Release_v4.4-GMC3/T210/Tegra210_Linux_R32.4.4_aarch64.tbz2 && \       
    tar xf Tegra210_Linux_R32.4.4_aarch64.tbz2 && \
    cd Linux_for_Tegra && \
    sed -i 's/config.tbz2\"/config.tbz2\" --exclude=etc\/hosts --exclude=etc\/hostname/g' apply_binaries.sh && \
    sed -i 's/install --owner=root --group=root \"${QEMU_BIN}\" \"${L4T_ROOTFS_DIR}\/usr\/bin\/\"/#install --owner=root --group=root \"${QEMU_BIN}\" \"${L4T_ROOTFS_DIR}\/usr\/bin\/\"/g' nv_tegra/nv-apply-debs.sh && \
    sed -i 's/LC_ALL=C chroot . mount -t proc none \/proc/ /g' nv_tegra/nv-apply-debs.sh && \
    sed -i 's/umount ${L4T_ROOTFS_DIR}\/proc/ /g' nv_tegra/nv-apply-debs.sh && \
    sed -i 's/chroot . \//  /g' nv_tegra/nv-apply-debs.sh && \
    ./apply_binaries.sh -r / --target-overlay && cd .. \
    rm -rf Tegra210_Linux_R32.4.4_aarch64.tbz2 && \
    rm -rf Linux_for_Tegra && \
    echo "/usr/lib/aarch64-linux-gnu/tegra" > /etc/ld.so.conf.d/nvidia-tegra.conf && ldconfig

WORKDIR /usr/local/cuda-10.2/samples/bin/aarch64/linux/release

CMD [ "sleep", "infinity" ]
