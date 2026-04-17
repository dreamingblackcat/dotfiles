FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y \
    curl git zsh bash sudo ca-certificates locales \
    build-essential unzip wget tzdata \
    && locale-gen en_US.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# Create non-root user chan with passwordless sudo
RUN useradd -m -s /bin/bash chan \
    && echo "chan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY test/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER chan
WORKDIR /home/chan

ENTRYPOINT ["/entrypoint.sh"]
