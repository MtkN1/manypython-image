ARG BASE_IMAGE="buildpack-deps" \
    VARIANT="noble"

# Build
# ------------------------------------------------------------------------------
FROM $BASE_IMAGE:$VARIANT AS build
    
ARG PYTHON_VERSION="3.13.0"

RUN set -eux; \
    \
    wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"; \
    mkdir -p /usr/src/python; \
    tar --extract --directory /usr/src/python --strip-components=1 --file python.tar.xz; \
    rm python.tar.xz; \
    \
    cd /usr/src/python; \
    ./configure \
        --with-ensurepip=no \
    ; \
    nproc="$(nproc)"; \
    make -j "$nproc" ; \
    make altinstall; \
    \
    cd /; \
    rm -rf /usr/src/python

# You must export the "/usr/local" directory to "rootfs.tar" outside of the Dockerfile.

# Runtime
# ------------------------------------------------------------------------------
FROM $BASE_IMAGE:$VARIANT AS runtime

ARG ROOTFS_TAR="rootfs.tar"

ADD $ROOTFS_TAR /
