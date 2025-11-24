FROM docker.io/bitnami/minideb:trixie

ARG BUILD_PACKAGES="\
    ca-certificates \
    cargo \
    gnupg \
    make \
    unzip \
    wget \
    xz-utils \
    zstd"

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

RUN cargo install kibi@0.3.1 && \
    mv /root/.cargo/bin/kibi /usr/local/bin/kibi

RUN wget https://github.com/qemacs/qemacs/archive/refs/heads/master.zip --directory-prefix=/tmp && \
    unzip /tmp/master.zip -d /tmp && \
    cd /tmp/qemacs-master && ./configure && make && make install

RUN wget https://github.com/microsoft/edit/releases/download/v1.2.0/edit-1.2.0-x86_64-linux-gnu.tar.zst --directory-prefix=/tmp && \
    zstd --decompress /tmp/edit-1.2.0-x86_64-linux-gnu.tar.zst && tar xf /tmp/edit-1.2.0-x86_64-linux-gnu.tar --directory=/tmp && \
    mv /tmp/edit /usr/local/bin/edit

RUN apt remove -y \
    ${BUILD_PACKAGES}
RUN apt autoremove -y

RUN rm -r /tmp/* /root/.cargo /root/.wget-hsts

COPY ./*.txt /root
COPY ./README.md /root
WORKDIR /root
