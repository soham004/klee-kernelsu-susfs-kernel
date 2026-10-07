cd KernelSU/
patch -p1 --dry-run --reverse --force < ../susfs4ksu/kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch >/dev/null 2>&1
if [ $? -ne 0 ]; then
    patch -p1 --forward < ../susfs4ksu/kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch
else
    echo "KernelSU Patch already applied, skipping."
fi

cd ../common/
patch -p1 --dry-run --reverse --force < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android15-6.6.patch
if [ $? -ne 0 ]; then
    patch -p1 --forward < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android15-6.6.patch
else
    echo "GKI Patch already applied, skipping."
fi
./compile.sh KSU '' ''
