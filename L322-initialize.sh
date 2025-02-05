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
# select the IMS org.
# for L322, this is "Adobe Commerce Extensibility", imsId: 0AD21DEB646C64020A495E65@AdobeOrg, id: 1244026
aio console org select 1244026

# install the mesh and commerce plugins
aio plugins:install @adobe/aio-cli-plugin-api-mesh@4.1.0-beta.3
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

if ! aio config get console.org | grep '1244026' > /dev/null; then
  echo "Incorrect ORG selected. Please run 'aio console org select 1244026'"
  exit 1
fi

echo "--- Setup complete ---"
