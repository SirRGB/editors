FROM docker.io/bitnami/minideb:trixie

ARG BUILD_PACKAGES="\
    ca-certificates \
    gnupg \
    wget"

RUN install_packages \
    ${BUILD_PACKAGES}

RUN wget -O- https://download.opensuse.org/download/repositories/home:/gphalkes:/tilde/xUbuntu_25.04/Release.key | gpg --dearmor | tee /etc/apt/keyrings/tilde.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/tilde.gpg] http://download.opensuse.org/repositories/home:/gphalkes:/tilde/xUbuntu_25.04 /" > /etc/apt/sources.list.d/tilde.list

RUN install_packages \
    emacs \
    hx \
    jed \
    kakoune \
    mc \
    micro \
    nano \
    ne \
    neovim \
    tilde \
    vim \
# clear
    ncurses-bin

RUN apt remove -y \
    ${BUILD_PACKAGES}
RUN apt autoremove -y

COPY ./*.txt /root
COPY ./README.md /root
WORKDIR /root
