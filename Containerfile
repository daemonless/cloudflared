ARG BASE_VERSION=15
FROM ghcr.io/daemonless/base:${BASE_VERSION}

ARG FREEBSD_ARCH=amd64
ARG PACKAGES="cloudflared"

# --- Metadata (Injected by Generator) ---
LABEL org.opencontainers.image.title="Cloudflared" \
      org.opencontainers.image.description="Cloudflare Tunnel client for exposing services securely." \
      org.opencontainers.image.source="https://github.com/daemonless/cloudflared" \
      org.opencontainers.image.url="https://developers.cloudflare.com/cloudflare-one/connections/connect-apps" \
      org.opencontainers.image.licenses="BSD-3-Clause" \
      org.opencontainers.image.vendor="daemonless" \
      org.opencontainers.image.authors="daemonless" \
      io.daemonless.category="Infrastructure" \
      io.daemonless.port="2000" \
      io.daemonless.arch="${FREEBSD_ARCH}" \
      io.daemonless.pkg-source="containerfile" \
      io.daemonless.packages="${PACKAGES}"

# Install cloudflared
RUN pkg update && \
    pkg install -y ${PACKAGES} && \
    pkg clean -ay && \
    rm -rf /var/cache/pkg/* /var/db/pkg/repos/*

# Copy root filesystem
COPY root/ /

# Set permissions
RUN chmod +x /etc/services.d/cloudflared/run /healthz

# --- Expose (Injected by Generator) ---
EXPOSE 2000

# --- Volumes (Injected by Generator) ---