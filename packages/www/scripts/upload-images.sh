#!/bin/bash

set -euo pipefail

BUCKET=www-img-kaito-tokyo

if [[ $CI -eq 1 ]]
then
  apt-get update
  apt-get install -y --no-install-recommends rclone
fi

rclone --version
