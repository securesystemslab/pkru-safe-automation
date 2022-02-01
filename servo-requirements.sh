#! /bin/bash

apt-get update &&                       \
        apt-get upgrade -y &&           \
        apt-get install -y bzip2        \
        git                             \
        locales                         \
        python                          \
        python-pip                      \
        tzdata                          \
        zstd                            \
        ca-certificates                 \
        dbus-x11                        \
        earlyoom                        \
        fluxbox                         \
        gdebi                           \
        pulseaudio                      \
        tzdata                          \
        sudo                            \
        unzip                           \
        wget                            \
        xvfb                            \
        firefox-esr                     \
        libnss3-tools                   \
        fonts-liberation                \
        ayatana-indicator-application   \
        libappindicator1                \
        libappindicator3-1              \
        libdbusmenu-gtk3-4              \
        libindicator3-7                 \
        libindicator7                   