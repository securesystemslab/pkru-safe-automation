FROM debian:buster

MAINTAINER Paul Kirth

ENV DEBIAN_FRONTEND noninteractive

## Get and install packages
RUN apt-get update &&                   \
        apt-get upgrade -y &&           \
        apt-get install -y apt-utils    \
        software-properties-common      \
        build-essential                 \
        sudo                            \
        vim-gtk                         \
        zsh                             \
        git                             \
        git-extras                      \
        git-flow                        \
        gcc                             \
        g++                             \
        golang-go                       \
        bison                           \
        flex                            \
        wget                            \
        curl                            \
        libcurl4-openssl-dev            \
        tmux                            \
        autotools-dev                   \
        autoconf                        \
        ninja-build                     \
        python3                         \
        python3-dev                     \
        python3-pip                     \
        exuberant-ctags                 \
        ruby                            \
        rake                            \
        nodejs                          \
        ack-grep                        \
        apt-transport-https             \
        cmake                           \
        docker                          \
        libgmp-dev                      \
        libmpc-dev                      \
        libmpfr-dev                     \
        nasm                            \
        texinfo                         \
        openssl                         \
        libssl-dev                      \
        libxml2-dev                     \
        stow                            \
        libpcre3-dev                    \
        clang                           \
        clang-format                    \
        clang-tidy                      \
        lld                             \
        llvm                            \
        llvm-dev                        \
        openssh-server                  \
        man                             \
        keychain                        \
        locales                         \
        locales-all                     \
        locate                          \
        fd-find                         \
        ripgrep                         \
        autoconf2.13                    \
        build-essential                 \
        ccache                          \
        gperf                           \
        libbz2-dev                      \
        libdbus-1-dev                   \
        libegl1-mesa-dev                \
        libfreetype6-dev                \
        libgl1-mesa-dri                 \
        libgles2-mesa-dev               \
        libglib2.0-dev                  \
        libglu1-mesa-dev                \
        libgstreamer-plugins-bad1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        libgstreamer1.0-dev             \
        libharfbuzz-dev                 \
        liblzma-dev                     \
        libosmesa6-dev                  \
        libunwind-dev                   \
        libx11-dev                      \
        libxmu-dev                      \
        libxmu6                         \
        python                          \
        python-dev                      \
        python-pip                      \
        python-virtualenv               \
        virtualenv                      \
        xorg-dev                        \
        bzip2                           \
        tzdata                          \
        zstd                            \
        ca-certificates                 \
        dbus-x11                        \
        earlyoom                        \
        fluxbox                         \
        gdebi                           \
        pulseaudio                      \
        unzip                           \
        xvfb                            \
        firefox-esr                     \
        libnss3-tools                   \
        fonts-liberation                \
        ayatana-indicator-application   \
        libappindicator1                \
        libappindicator3-1              \
        libdbusmenu-gtk3-4              \
        libindicator3-7                 \
        libindicator7                   \
        && apt-get autoremove -y        \
        && apt-get clean                \
        && rm -rf /var/lib/apt/lists/*

## Set the locale
RUN locale-gen "en_US.UTF-8"
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US:en"
ENV LC_ALL "en_US.UTF-8"
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

WORKDIR /root

## Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y

## Grab compatible LLVM version for building Rust
WORKDIR /root
RUN git clone -b pkru-safe https://github.com/securesystemslab/llvm-project.git

## Grab custom Rust build
WORKDIR /root
RUN git clone -b pkru-safe https://github.com/securesystemslab/rust.git

## Build Servo testing directory
WORKDIR /root
RUN mkdir mpk-test-dir

## Grab automation folder
WORKDIR /root/mpk-test-dir
RUN git clone https://github.com/securesystemslab/pkru-safe-automation.git automation

## Build clang
WORKDIR /root/mpk-test-dir/automation
RUN ./build_clang.sh

## Build Rust using built version of Clang
WORKDIR /root/mpk-test-dir/automation
RUN ./build_rust.sh

## Grab different versions of Servo
WORKDIR /root/mpk-test-dir
RUN git clone -b vanilla https://github.com/securesystemslab/pkru-safe-servo.git servo-vanilla
RUN git clone -b pkru-safe-step https://github.com/securesystemslab/pkru-safe-servo.git servo-step
RUN git clone -b no-mpk https://github.com/securesystemslab/pkru-safe-servo.git servo-step-no-mpk

WORKDIR /root

## Run zsh as login shell
ENTRYPOINT ["/usr/bin/zsh"]
CMD ["--login"]
