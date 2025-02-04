#!/bin/bash
echo "Hello Seat ${SEAT}"

# Login to gh cli with token
echo "${GITHUB_TOKEN}" > ~/.git-token
gh auth login --with-token < ~/.git-token

# Ensure correct aio env used, and login
aio telemetry off
aio config set cli.env prod
# perform login, should automatically authenticate since lab machines are being pre-authenticated to experience.adobe.com (prod IMS) on browser.
#aio login

# install aio cli as well as the mesh and commerce plugins
npm install -g @adobe/aio-cli
aio plugins:install @adobe/aio-cli-plugin-api-mesh@4.1.0-beta.3
aio plugins:install https://github.com/adobe-commerce/aio-cli-plugin-commerce

# TODO validate aio installation
# such as IMS org used, plugins installed properly, etc.

echo "--- Setup complete ---"
