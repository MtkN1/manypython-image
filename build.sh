#!/bin/sh -eux

BASE_IMAGE="${BASE_IMAGE:-buildpack-deps}"
VARIANT="${VARIANT:-noble}"
PYTHON_VERSION="${PYTHON_VERSION:-3.13.0}"

# Build the rootfs
docker buildx build \
    --build-arg BASE_IMAGE="$BASE_IMAGE" \
    --build-arg VARIANT="$VARIANT" \
    --build-arg PYTHON_VERSION="$PYTHON_VERSION" \
    --file Dockerfile.build \
    --output "type=local,dest=rootfs-$PYTHON_VERSION" \
    .

# Create the tarball
tar -C "rootfs-$PYTHON_VERSION" -cf "rootfs-$PYTHON_VERSION.tar" usr/local

# Clean up
rm -rf "rootfs-$PYTHON_VERSION"

# Extract the individual rootfs
mkdir "rootfs-$PYTHON_VERSION"
tar -C "rootfs-$PYTHON_VERSION" -xf "rootfs-$PYTHON_VERSION.tar"

# Combine the rootfs
tar -C "rootfs-$PYTHON_VERSION" -rf "rootfs.tar" usr/local
