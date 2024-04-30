FROM ubuntu:22.04

MAINTAINER satakujp, <https://github.com/satakujp>

RUN apt-get update

# Doxygenと図表生成のためにgraphvizをインストールする。
RUN apt-get install -y doxygen graphviz && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
WORKDIR /doxygen

# 作業用ユーザー作成
ARG USERNAME=doxygen
ARG GROUPNAME=doxygen
ARG UID=1001
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME
