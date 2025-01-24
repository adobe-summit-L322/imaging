#!/bin/bash

echo "Hello Seat ${SEAT}"

# Login to gh cli with token
echo "${GITHUB_TOKEN}" > ~/.git-token
gh auth login --with-token < ~/.git-token

# Login to aio cli
# ensure correct env used
aio config set cli.env prod
# perform login, should automatically
aio login

# install mesh and commerce plugins
aio plugins add @adobe/aio-cli-plugin-api-mesh
aio plugins add https://github.com/adobe-commerce/aio-cli-plugin-commerce

# TODO validate aio installation
# such as IMS org used, plugins installed properly, etc.

echo "--- Setup complete ---"
