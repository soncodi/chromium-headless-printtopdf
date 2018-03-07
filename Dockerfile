FROM ubuntu:xenial

MAINTAINER Alex Soncodi

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    wget \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN apt-add-repository multiverse

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] https://dl-ssl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update && apt-get install -y \
    ttf-mscorefonts-installer \
    google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN useradd headless --shell /bin/bash --create-home \
  && usermod -a -G sudo headless \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'headless:nopassword' | chpasswd

RUN mkdir -p /data && chown -R headless:headless /data

ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# avoid running as root + --no-sandbox
USER headless

CMD [ \
  "/usr/bin/google-chrome-stable", \
  "--disable-gpu", \
  "--headless", \
  "--hide-scrollbars", \
  "--remote-debugging-address=0.0.0.0", \
  "--remote-debugging-port=9222", \
  "--user-data-dir=/data"]
