#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

VERSION=$(git describe)

JAZZY=$(which jazzy)

if [ -z "${JAZZY}" ]; then
    echo "Please install 'jazzy' from https://github.com/realm/jazzy"
    exit 1
fi

jazzy \
  --clean \
  --author dsaiko \
  --author_url https://github.com/dsaiko \
  --github_url https://github.com/dsaiko/SachistaChess2 \
  --github-file-prefix https://github.com/dsaiko/SachistaChess2/blob/release/${VERSION} \
  --module-version ${VERSION}

open docs/index.html
