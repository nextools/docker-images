# chromium

[![version](https://img.shields.io/badge/version-80.0.3987.149-blue.svg?style=flat-square)](https://packages.ubuntu.com/bionic/chromium-browser)

Dockerized Chromium in [headless + remote debugging mode](https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md).

## Usage

### Login

See [login section](../readme.md#login) in the root readme.

### Versions

Chromium version is atomatically split into multiple Docker tags ("versions"), for example version `80.0.3987.87` produces `80`, `80.0`, `80.0.3987`, `80.0.3987.87` and `latest`. See the [list of versions available to use](https://github.com/nextools/images/packages/165734/versions).

### Run

```sh
docker run -it --rm -p 9222:9222 docker.pkg.github.com/nextools/images/chromium:<VERSION>
```

### Puppeteer

Ensure to match version of [`puppeteer-core`](https://github.com/GoogleChrome/puppeteer) to the version of Chromium you are using:

```sh
yarn add puppeteer-core@chrome-<MAJOR_VERSION>
```

```js
import fetch from 'node-fetch'
import puppeteer from 'puppeteer-core'

const response = await fetch('http://localhost:9222/json/version')
const { webSocketDebuggerUrl } = await response.json()

const browser = await puppeteer.connect({ browserWSEndpoint: webSocketDebuggerUrl })
const page = await browser.newPage()

await page.goto('https://example.com')
await page.screenshot({ path: 'example.png' })
await browser.close()
```

## How to

### specify a different port

Container uses a `RD_PORT` [environment variable](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file), which is `9222` by default:

```
docker run -it --rm -p 9223:9223 -e RD_PORT=9223 docker.pkg.github.com/nextools/images/chromium:<VERSION>
```

### pass additional Chromium arguments

```
docker run -it --rm -p 9222:9222 docker.pkg.github.com/nextools/images/chromium:<VERSION> --some-chromium-arg
```

### add custom fonts

It's possible to mount a folder with custom fonts to be used later by Chromium: 

```
docker run -it --rm -p 9222:9222 -v $(pwd)/path/to/fonts:/home/chromium/.fonts docker.pkg.github.com/nextools/images/chromium:<VERSION>
```

### push necessary tags out of new version

1. `make get-version` to print the full version of the latest [Chromium for Ubuntu "Bionic" 18.04 LTS](https://packages.ubuntu.com/bionic/chromium-browser)
2. `make tags version=<VERSION>` to automatically make and push 5 tags
