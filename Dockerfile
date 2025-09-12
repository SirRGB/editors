FROM docker.io/bitnami/minideb:trixie

RUN install_packages \
    emacs \
#    helix \
    kakoune \
    micro \
    nano \
    ne \
    neovim \
    vim

COPY ./*.txt /root
