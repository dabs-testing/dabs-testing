#!/bin/bash
set -euo pipefail  # More robust error handling

# This script is used to install the Databricks CLI.
# It is used in the bitbucket-pipelines.yml file.
# It has been modified to install the CLI to ~/.cache/databricks that will be cached.
# Please refer to https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh for the original script.
VERSION="0.237.0"
FILE="databricks_cli_${VERSION}_linux_amd64"
TARGET="${HOME}/.cache/databricks"

# Make cache directory
mkdir -p "${TARGET}"
cd "${TARGET}" || exit 1

# Download release archive with error handling
if ! curl -L -s -O "https://github.com/databricks/cli/releases/download/v${VERSION}/${FILE}.zip"; then
    echo "Error: Failed to download Databricks CLI" >&2
    exit 1
fi

# Unzip release archive.
unzip -o -q "${FILE}.zip"

# Make databricks executable
chmod +x "${TARGET}/databricks"

# Generate artifact
echo 'export PATH=$PATH:~/.cache/databricks' >> $GITHUB_WORKSPACE/set_path.sh