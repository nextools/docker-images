FROM ubuntu:bionic

ARG VERSION
ARG DEBIAN_FRONTEND=noninteractive
ENV DBUS_SESSION_BUS_ADDRESS disabled:
ENV RD_PORT=9222

RUN apt-get update \
    # https://github.com/phusion/baseimage-docker/issues/319
    && apt-get install --yes apt-utils 2>&1 | grep -v "debconf: delaying package configuration, since apt-utils is not installed" \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
    && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] https://dl-ssl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && wget --no-verbose -O /tmp/chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${VERSION}_amd64.deb \
    && apt-get update \
    && apt-get install -y /tmp/chrome.deb fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros fonts-kacst fonts-freefont-ttf libxss1 dumb-init socat dbus dbus-x11 \
      --no-install-recommends \
    && service dbus start \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r chrome && useradd --create-home -rm -g chrome -G audio,video chrome


WORKDIR /home/chrome

COPY --chown=chrome:chrome entrypoint.sh /home/chrome/

USER chrome

ENTRYPOINT ["dumb-init", "--", "/bin/sh", "/home/chrome/entrypoint.sh"]
