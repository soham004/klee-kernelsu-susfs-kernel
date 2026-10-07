#!/bin/bash

# Array of commands to check
REQUIRED_COMMANDS=("docker" "git")
MISSING_COMMANDS=()

# Check each command
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        MISSING_COMMANDS+=("$cmd")
    fi
done

# If any command is missing, print error messages and exit
if [ ${#MISSING_COMMANDS[@]} -ne 0 ]; then
    echo "Error: The following required programs are not installed:" >&2
    for cmd in "${MISSING_COMMANDS[@]}"; do
        echo "  - $cmd" >&2
    done
    exit 1
fi

echo "All dependencies (Docker & Git) are installed!"

git clone https://github.com/soham004/klee-kernelsu-susfs-kernel.git
cd klee-kernelsu-susfs-kernel
git submodule update --init --depth=1 common
git submodule update --init KernelSU
git submodule update --init susfs4ksu

docker build -t klee-kernel-builder -f Dockerfile .

docker run --rm -i \
    -v "$PWD:/workspace" \
    -w /workspace \
    klee-kernel-builder \
    bash -c "chmod +x compile.sh && ./compile.sh"