#!/bin/bash
git config --global --add safe.directory /workspace
git config --global --add safe.directory /workspace/KernelSU
git config --global --add safe.directory /workspace/common
git config --global --add safe.directory /workspace/susfs4ksu

cd KernelSU/
git rev-list --count HEAD
git restore .
patch -p1 --dry-run --reverse --force < ../susfs4ksu/kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch >/dev/null 2>&1
if [ $? -ne 0 ]; then
    patch -p1 --forward < ../susfs4ksu/kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch
else
    echo "KernelSU Patch already applied, skipping."
fi

cd ../common/
git restore .
git rev-list --count HEAD
patch -p1 --dry-run --reverse --force < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android15-6.6.patch >/dev/null 2>&1
if [ $? -ne 0 ]; then
    patch -p1 --forward < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android15-6.6.patch
else
    echo "GKI Patch already applied, skipping."
fi

rm -rf drivers/kernelsu
ln -s ../../KernelSU/kernel drivers/kernelsu
cp ../susfs4ksu/kernel_patches/fs/* fs/
cp ../susfs4ksu/kernel_patches/include/linux/* include/linux/
sed -i 's/CONFIG_LOCALVERSION="-rethinking"/CONFIG_LOCALVERSION="-ahmos"/' arch/arm64/configs/gki_defconfig
sed -i 's/ZIP_PREFIX="rethinking-GKI"/ZIP_PREFIX="ahmos-GKI"/' compile.sh
make clean
find . -type d -name 'anykernel*' -prune -exec rm -rf -- {} +

./compile.sh KSU '' ''
