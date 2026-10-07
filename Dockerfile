FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bc \
    bison \
    build-essential \
    ca-certificates \
    cpio \
    device-tree-compiler \
    dwarves \
    flex \
    git \
    kmod \
    libelf-dev \
    libncurses-dev \
    libssl-dev \
    libxml2 \
    lz4 \
    perl \
    python3 \
    rsync \
    wget \
    zip \
    zstd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["bash"]