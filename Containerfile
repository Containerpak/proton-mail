FROM ubuntu:26.04 AS source

ADD --checksum=sha256:9ba97623f2eaaf5ebe6c01048804bffdeb6c25e445aebdc9dcae04eb1bb77759 https://proton.me/download/mail/linux/1.13.4/ProtonMail-desktop-beta.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/proton-mail"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/proton-mail.png
COPY proton-mail.desktop /usr/share/applications/proton-mail.desktop
