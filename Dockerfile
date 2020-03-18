FROM ubuntu:latest
LABEL maintainer="aa <bb@cc.dd>"

RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    git-core \
    gnupg \
    linuxbrew-wrapper \
    locales \
    zsh \
    wget \
    vim \
    nano \
    npm \
    fonts-powerline && \
    locale-gen en_US.UTF-8 && \
    adduser --quiet --disabled-password --shell /bin/zsh --home /home/devuser --gecos "User" devuser && \
    echo "devuser:userpassword" | chpasswd &&  usermod -aG sudo devuser

USER devuser
ENV TERM xterm
CMD ["zsh"]
