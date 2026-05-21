FROM docker.io/debian:trixie-slim AS builder

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    cargo \
    gnupg \
    make \
    parallel \
    unzip \
    wget \
    xz-utils

RUN parallel :::\
# tilde
    "wget -O- https://download.opensuse.org/download/repositories/home:/gphalkes:/tilde/xUbuntu_25.04/Release.key | gpg --dearmor | tee /etc/apt/keyrings/tilde.gpg" \
# kibi
    "cargo install kibi@0.3.1" \
# orbiton
    "wget https://github.com/xyproto/orbiton/releases/download/v2.74.2/orbiton-2.74.2-linux_x86_64_static.tar.xz --directory-prefix=/tmp && \
    tar xf /tmp/orbiton-2.74.2-linux_x86_64_static.tar.xz --directory=/tmp --no-same-owner" \
# qemacs
    "wget https://github.com/qemacs/qemacs/archive/refs/heads/master.zip --directory-prefix=/tmp && \
    unzip /tmp/master.zip -d /tmp && cd /tmp/qemacs-master && ./configure && make && make install" \
# edit
    "wget https://github.com/microsoft/edit/releases/download/v2.0.0/edit-2.0.0-x86_64-linux-gnu.tar.gz --directory-prefix=/tmp && \
    tar zxf /tmp/"edit-2.0.0-x86_64-linux-gnu.tar.gz" --directory=/tmp"


FROM docker.io/debian:trixie-slim AS runner
ARG INSTALL_PATH=/usr/local/bin

COPY --from=builder /etc/apt/keyrings/tilde.gpg /etc/apt/keyrings/tilde.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/tilde.gpg] http://download.opensuse.org/repositories/home:/gphalkes:/tilde/xUbuntu_25.04 /" > /etc/apt/sources.list.d/tilde.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
# clear
    ncurses-bin \
# editors
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
    zile

COPY --from=builder /root/.cargo/bin/kibi "${INSTALL_PATH}"/kibi

COPY --from=builder /tmp/orbiton-2.74.2-linux_x86_64_static/o "${INSTALL_PATH}"/o

COPY --from=builder /usr/local/bin/qe /usr/local/bin/qemacs "${INSTALL_PATH}"/

COPY --from=builder /tmp/edit "${INSTALL_PATH}"/edit


RUN rm --recursive /var/lib/apt/lists /var/cache/apt/archives

COPY ./*.txt ./README.md /root
WORKDIR /root
