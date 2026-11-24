#!/usr/bin/env bash
# Pass 3: shared team docs, M1 guide screenshots, play video captures -> assets/
set -euo pipefail
pip install -q pillow
mkdir -p work out/main/assets
gd(){ gdown -q "$1" -O "$2"; }
gd 171gz08CiTHh53IDAkS_3zTghx7N9p39i work/guide.pdf
gd 1rSVNP2ffglw-E81ZQbLl1k_Wqm5HNFMr work/concept.pdf
gd 13WbEMoydhjPQq1JYEhyoonGQVQf_3ls4 work/m1scope.pdf
curl -sSL "https://docs.google.com/presentation/d/1xrsUv_40_wQQjMGSjILrkiwvWs-ztYTS5-x_AKJY__0/export/pdf" -o work/idea.pdf
gd 1gKJOqLCXu1OXvTF4W246B0GU2ar7Iuci work/rec.mp4
for p in 2 4 9 11 13 14 15; do pdftoppm -r 150 -png -f $p -l $p work/guide.pdf work/g$p; done
pdftoppm -r 110 -png work/concept.pdf work/cp
pdftoppm -r 110 -png work/m1scope.pdf work/ms
pdftoppm -r 90 -png work/idea.pdf work/id
mkdir -p work/v && ffmpeg -loglevel error -i work/rec.mp4 -vf "fps=1/4,scale=960:-2" -q:v 2 work/v/f_%04d.jpg
python3 tools/make.py
ls -la out/main/assets
