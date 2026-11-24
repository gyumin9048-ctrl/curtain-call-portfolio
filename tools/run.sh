#!/usr/bin/env bash
# Pass 2: high-res pages of the M1 public guide (branch "raw")
set -euo pipefail
mkdir -p work out/raw/guide_hi
gdown -q 171gz08CiTHh53IDAkS_3zTghx7N9p39i -O work/guide.pdf
for p in 1 2 15 16 17 18; do pdftoppm -r 130 -jpeg -jpegopt quality=88 -f $p -l $p work/guide.pdf out/raw/guide_hi/g$p; done
ls -la out/raw/guide_hi
