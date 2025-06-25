FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ARG HOST_UID=1000
ARG HOST_GID=1000
ARG HOST_USER=sanyinchen

# 一次性安装所有依赖并清理 APT 缓存
RUN apt update && apt install -y --fix-missing \
    bochs \
    bochs-sdl \
    bochs-x \
    bochs-term \
    build-essential \
    nasm \
    gcc \
    g++ \
    make \
    gcc-x86-64-linux-gnu \
    sudo \
    x11-apps \
    xauth \
    xterm \
    cmake \
    mtools \
    dosfstools

# 创建与宿主一致的用户/组
RUN groupadd -g ${HOST_GID} ${HOST_USER} && \
    useradd  -m -u ${HOST_UID} -g ${HOST_GID} ${HOST_USER} && \
    echo "${HOST_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${HOST_USER}
WORKDIR /home/${HOST_USER}

# 默认启动 bash
CMD ["/bin/bash"]
