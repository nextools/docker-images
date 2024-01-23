#!/bin/sh
#!/bin/sh

socat tcp-listen:9222,bind="$(hostname --ip-address)",fork tcp:127.0.0.1:9222 &

google-chrome-stable \
  --allow-pre-commit-input \
  --disable-background-networking \
  --disable-background-timer-throttling \
  --disable-backgrounding-occluded-windows \
  --disable-breakpad \
  --disable-client-side-phishing-detection \
  --disable-component-extensions-with-background-pages \
  --disable-component-update \
  --disable-setuid-sandbox \
  --disable-default-apps \
  --disable-speech-api \
  --disable-dev-shm-usage \
  --disable-domain-reliability \
  --disable-notifications \
  --disable-extensions \
  --disable-field-trial-config \
  --disable-hang-monitor \
  --disable-infobars \
  --disable-ipc-flooding-protection \
  --disable-popup-blocking \
  --disable-prompt-on-repost \
  --disable-renderer-backgrounding \
  --disable-search-engine-choice-screen \
  --disable-offer-store-unmasked-wallet-cards \
  --disable-sync \
  --disable-print-preview \
  --noerrdialogs \
  --enable-automation \
  --export-tagged-pdf \
  --force-color-profile=srgb \
  --metrics-recording-only \
  --no-first-run \
  --no-default-browser-check \
  --no-sandbox \
  --no-zygote \
  --start-maximized \
  --password-store=basic \
  --use-mock-keychain \
  --window-size=1980,1080 \
  --disable-features=Translate,AcceptCHFrame,MediaRouter,OptimizationHints,ProcessPerSiteUpToMainFrameThreshold \
  --enable-features=NetworkServiceInProcess2 \
  --user-data-dir=/home/chrome/ \
  --headless=new \
  --hide-scrollbars \
  --mute-audio \
  --ignore-certificate-errors \
  --ignore-certificate-errors-spki-list \
  --ignore-ssl-errors \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port=9222
  about:blank
