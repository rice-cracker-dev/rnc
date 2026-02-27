#!/usr/bin/env bash

GET_RELEASE_API_URL="https://api.github.com/repos/imputnet/helium-linux/releases/latest"
LATEST_TAG=$(curl -s "$GET_RELEASE_API_URL" | jq -r '.tag_name')
LATEST_URL="https://github.com/imputnet/helium-linux/releases/download/${LATEST_TAG}/helium-${LATEST_TAG}-x86_64.AppImage"
LATEST_HASH="sha256-$(nix hash convert --from nix32 --to base64 --hash-algo sha256 $(nix-prefetch-url "${LATEST_URL}"))"

sed -i "s/version = \".*\";/version = \"$LATEST_TAG\";/" ./package.nix
sed -i "s|hash = \".*\";|hash = \"$LATEST_HASH\";|" ./package.nix # base64 contains slash (/)
