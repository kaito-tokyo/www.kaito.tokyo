#!/bin/bash

set -euo pipefail

BUCKET=www-img-kaito-tokyo

if ! command -v rclone
then
  apt-get update
  apt-get install -y --no-install-recommends rclone
fi

rclone --version
