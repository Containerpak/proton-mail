FROM ubuntu:26.04 AS source

ADD --checksum=sha256:c81e5e297856f5b986c47b2338a665348d897cdf025c5cf53f3dbeefb0cf6288 https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/proton-mail"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/proton-mail.png
COPY proton-mail.desktop /usr/share/applications/proton-mail.desktop
