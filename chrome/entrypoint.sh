#!/bin/sh

if [ "$(ls -A /home/chrome/.fonts/)" ]; then
  fc-cache -f -v
fi

RD_PORT="${RD_PORT:=9222}"

ip=$(hostname --ip-address)
socat tcp-listen:$RD_PORT,bind="$ip",fork tcp:127.0.0.1:$RD_PORT &

(ulimit -n 65000 || true) && (ulimit -p 65000 || true) && exec google-chrome-stable \
  --enable-automation \
  --silent-debugger-extension-api \
  --allow-pre-commit-input \
  --ash-no-nudges \
  --disable-gpu-process-crash-limit \
  --disable-background-networking \
  --disable-background-timer-throttling \
  --disable-backgrounding-occluded-windows \
  --disable-renderer-backgrounding \
  --disable-breakpad \
  --disable-client-side-phishing-detection \
  --disable-setuid-sandbox \
  --disable-default-apps \
  --disable-speech-api \
  --disable-dev-shm-usage \
  --disable-domain-reliability \
  --disable-notifications \
  --disable-extensions \
  --disable-field-trial-config \
  --disable-popup-blocking \
  --disable-prompt-on-repost \
  --disable-search-engine-choice-screen \
  --disable-offer-store-unmasked-wallet-cards \
  --disable-sync \
  --disable-component-extensions-with-background-pages \
  --deny-permission-prompts \
  --disable-print-preview \
  --noerrdialogs \
  --disable-hang-monitor \
  --disable-ipc-flooding-protection \
  --disable-component-update \
  --headless=new \
  --export-tagged-pdf \
  --force-color-profile=srgb \
  --no-zygote \
  --start-maximized \
  --password-store=basic \
  --use-mock-keychain \
  --disable-features=Translate,AcceptCHFrame,MediaRouter,OptimizationHints,ProcessPerSiteUpToMainFrameThreshold,ImprovedCookieControls \
  --enable-features=NetworkServiceInProcess2 \
  --hide-scrollbars \
  --ignore-certificate-errors \
  --ignore-certificate-errors-spki-list \
  --ignore-ssl-errors \
  --ignore-unknown-auth-factors \
  --metrics-recording-only \
  --mute-audio \
  --no-first-run \
  --no-sandbox \
  --no-default-browser-check \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port="$RD_PORT" \
  --user-data-dir=/home/chrome/ \
  --window-size=1920,1080 \
  --window-position=0,0 \
  "$@"
