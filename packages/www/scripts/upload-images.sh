#!/bin/bash

set -euo pipefail

BUCKET=www-img-kaito-tokyo

if [[ $CF_PAGES = 1 ]]
then
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends rclone
fi

rclone --version
