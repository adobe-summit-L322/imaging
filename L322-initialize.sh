#!/bin/bash
echo "Hello Seat ${SEAT}"

# Login to gh cli with token
echo "${GITHUB_TOKEN}" > ~/.git-token
gh auth login --with-token < ~/.git-token

# install aio cli and ensure correct aio env used, and login
npm install -g @adobe/aio-cli
aio telemetry off
aio config set cli.env prod
# perform login, should automatically authenticate since lab machines are being pre-authenticated to experience.adobe.com (prod IMS) on browser.
#aio login
# select the IMS org, this is "Adobe Commerce Extensibility", 0AD21DEB646C64020A495E65@AdobeOrg
aio console org select 1244026

# install the mesh and commerce plugins
aio plugins:install @adobe/aio-cli-plugin-api-mesh@4.1.0-beta.3
aio plugins:install https://github.com/adobe-commerce/aio-cli-plugin-commerce

# TODO validate aio installation
# such as IMS org used, plugins installed properly, etc.

echo "--- Setup complete ---"
