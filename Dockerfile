FROM docker.io/bitnami/minideb:trixie

RUN install_packages \
    emacs \
    hx \
    kakoune \
    mc \
    micro \
    nano \
    ne \
    neovim \
    vim \
# clear
    ncurses-bin

COPY ./*.txt /root
COPY ./README.md /root
WORKDIR /root
