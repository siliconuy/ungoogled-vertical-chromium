FROM gitpod/workspace-full

USER root

# Instalación de CMake
RUN CMAKE_VERSION="3.22.2" \
    && mkdir -p /opt/cmake \
    && architecture=$(dpkg --print-architecture) \
    && case "${architecture}" in \
        arm64) ARCH=aarch64 ;; \
        amd64) ARCH=x86_64 ;; \
        *) echo "Unsupported architecture ${architecture}." && exit 1 ;; \
       esac \
    && CMAKE_BINARY_NAME="cmake-${CMAKE_VERSION}-linux-${ARCH}.sh" \
    && CMAKE_CHECKSUM_NAME="cmake-${CMAKE_VERSION}-SHA-256.txt" \
    && cd /tmp \
    && curl -sSL "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_BINARY_NAME}" -O \
    && curl -sSL "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_CHECKSUM_NAME}" -O \
    && sha256sum -c --ignore-missing "${CMAKE_CHECKSUM_NAME}" \
    && sh "${CMAKE_BINARY_NAME}" --prefix=/opt/cmake --skip-license \
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake \
    && ln -s /opt/cmake/bin/ctest /usr/local/bin/ctest \
    && rm -rf /tmp/*

USER gitpod 