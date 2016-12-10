FROM base/archlinux:latest

RUN pacman -Syy --noconfirm > /dev/null
RUN pacman -Syu --noconfirm &> /dev/null
RUN pacman-db-upgrade > /dev/null
USER root
