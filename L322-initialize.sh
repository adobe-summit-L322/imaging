#!/bin/bash
echo "Hello Seat ${SEAT}"

# Login to gh cli with token
echo "${GITHUB_TOKEN}" > ~/.git-token
gh auth login --with-token < ~/.git-token

# install aio cli and ensure correct aio env used, and login
npm install -g @adobe/aio-cli
aio telemetry on
aio config set cli.env prod
# perform login, should automatically authenticate since lab machines are being pre-authenticated to experience.adobe.com (prod IMS) on browser.
aio login
# select the IMS org.
# for L322, this is "Commerce Extensibility Lab", imsId: 045013D3664331DC0A495CD5@AdobeOrg, id: 3117813
# for L321, this is "Adobe Commerce Project Beacon", imsId: DEDB2A52641B1D460A495F8E@AdobeOrg, id: 1172492
aio console org select ${ORG_ID}

# install the mesh and commerce plugins
aio plugins:install @adobe/aio-cli-plugin-api-mesh
aio plugins:install https://github.com/adobe-commerce/aio-cli-plugin-commerce

echo "Verifying installation..."
if ! aio -v | grep '@adobe/aio-cli' > /dev/null; then
  echo "AIO not installed"
  exit 1
fi

if ! aio plugins | grep '@adobe/aio-cli-plugin-api-mesh' > /dev/null; then
  echo "@adobe/aio-cli-plugin-api-mesh not installed!"
  exit 1
fi

if ! aio plugins | grep '@adobe/aio-cli-plugin-commerce' > /dev/null; then
  echo "@adobe/aio-cli-plugin-commerce not installed!"
  exit 1
fi

if ! aio config get console.org | grep '3117813' > /dev/null; then
  echo "Incorrect ORG selected. Please run 'aio console org select 3117813'"
  exit 1
fi

echo "--- Setup complete ---"
