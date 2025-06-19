FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和运行 Bochs 所需依赖
# 先去掉 bochs-doc bochs-bochsdbg 看能否构建通过
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
    xterm \
    cmake \
    mtools \
    dosfstools \
    locales && \
    rm -rf /var/lib/apt/lists/*


# 创建非 root 用户，适合开发体验
RUN useradd -ms /bin/bash user && echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER user
WORKDIR /home/user

# 启动容器后默认进入 bash
CMD ["/bin/bash"]
