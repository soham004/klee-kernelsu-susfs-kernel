# Klee KernelSU SUSFS Kernel

Build the Klee kernel with KernelSU and SUSFS support using the included Docker
environment.

## Prerequisites

- Docker
- Git

## Build

### 1. Clone the repository

Clone the repository and its submodules:

```bash
git clone \
    https://github.com/soham004/klee-kernelsu-susfs-kernel.git \
    klee-kernelsu-susfs-kernel
cd klee-kernelsu-susfs-kernel
```
### 2. Initialize Submodules 

```bash
git submodule update --init --depth=1 common
git submodule update --init KernelSU
git submodule update --init susfs4ksu
```

### 3. Build the Docker image

```bash
docker build -t klee-kernel-builder -f Dockerfile .
```

### 4. Start the build container

Mount the repository into the container and start an interactive shell:

```bash
docker run --rm -it \
    -v "$PWD:/workspace" \
    -w /workspace \
    klee-kernel-builder \
    bash
```

### 5. Build the kernel

Run the following commands inside the container. The script applies the
required KernelSU and SUSFS patches before starting the kernel build.

```bash
chmod +x compile.sh
./compile.sh
```

## Notes

- Run the build from the repository root.
- The compile script detects and skips patches that have already been applied.
