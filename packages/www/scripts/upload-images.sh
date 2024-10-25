#!/bin/bash

set -euo pipefail

BUCKET=www-img-kaito-tokyo

for artwork_dir in src/routes/artworks/2*
do
  prefix=${artwork_dir#src/routes/}
  for image in $artwork_dir/*.{png,webp}
  do
    name=${image##*/}
    npx wrangler r2 object put "$BUCKET/$prefix/$name" -f "$image"
  done
done
