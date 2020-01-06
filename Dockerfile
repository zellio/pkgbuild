## -*- docker-image-name: "pkgbuild-builder" -*-

FROM archlinux:latest

MAINTAINER Zachary Elliott <contact@zell.io>

ENV package ""

RUN useradd --home-dir /var/lib/notroot --user-group notroot

RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman --sync --refresh --noconfirm archlinux-keyring && \
    pacman --sync --refresh --noconfirm --sysupgrade && \
    pacman --sync --refresh --noconfirm base-devel git

RUN echo "notroot	ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/00_notroot

ADD .git /var/lib/notroot/repo/.git

RUN chown -R notroot:notroot /var/lib/notroot

USER notroot
WORKDIR /var/lib/notroot/repo

ENTRYPOINT [ "bash",  "-c", "branch=${branch} && package=${package:-${branch#package/}} && git checkout package/${package} && sudo pacman --sync --refresh && makepkg --clean --cleanbuild --log --syncdeps --rmdeps --noconfirm && sudo mv ./${package}*.pkg.tar.xz /mnt/return_target" ]
