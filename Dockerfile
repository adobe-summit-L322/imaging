# Mimic initial state of Lab Laptops
# Usage steps
# 1. docker build -t setup-test .
# 2. docker run -it -e GITHUB_TOKEN="GITHUB_TOKEN" --entrypoint=/bin/bash --rm setup-test
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install gh -y

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs
RUN node -v

# Install Adobe I/O CLI
RUN npm install -g @adobe/aio-cli
# Copy your script into the container
COPY --chmod=0755 L322-initialize.sh /L322-initialize.sh

# Set environment variables
ENV SEAT="YourSeat"

# When running with GITHUB_TOKEN, gh cli will be automatically authenticated
# Either pass with ENV:
# ENV GITHUB_TOKEN="YOUR_TOKEN"
# or more securely, pass from docker run:
# docker run -it -e GITHUB_TOKEN="YOUR_TOKEN" --entrypoint=/bin/bash setup-test

# Run your script
# CMD ["bash", "/L322-initialize.sh"]
