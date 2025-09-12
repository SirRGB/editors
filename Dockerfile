FROM docker.io/bitnami/minideb:trixie

ARG BUILD_PACKAGES="\
    ca-certificates \
    gnupg \
    wget \
    xz-utils"

RUN install_packages \
    ${BUILD_PACKAGES}

RUN wget -O- https://download.opensuse.org/download/repositories/home:/gphalkes:/tilde/xUbuntu_25.04/Release.key | gpg --dearmor | tee /etc/apt/keyrings/tilde.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/tilde.gpg] http://download.opensuse.org/repositories/home:/gphalkes:/tilde/xUbuntu_25.04 /" > /etc/apt/sources.list.d/tilde.list

RUN install_packages \
    e3 \
    emacs-nox \
    hx \
    jed \
    kakoune \
    kilo \
    mc \
    mg \
    micro \
    mle \
    nano \
    nano-tiny \
    ne \
    neovim \
    tilde \
    vile \
    vim \
    vis \
    yi \
    zile \
# clear
    ncurses-bin

RUN wget https://github.com/xyproto/orbiton/releases/download/v2.70.0/orbiton-2.70.0-linux_x86_64_static.tar.xz --directory-prefix=/tmp && \
    tar xf /tmp/orbiton-2.70.0-linux_x86_64_static.tar.xz --directory=/tmp && \
    mv /tmp/orbiton-2.70.0-linux_x86_64_static/o /usr/local/bin/o

RUN apt remove -y \
    ${BUILD_PACKAGES}
RUN apt autoremove -y

COPY ./*.txt /root
COPY ./README.md /root
WORKDIR /root
