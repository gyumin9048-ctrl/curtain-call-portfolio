#!/usr/bin/env bash
# Pass 8: candidate frames (final 11/22, playtest 11/12) -> raw branch
set -euo pipefail
mkdir -p work out/raw/fin out/raw/pt1
gdown -q 1RRoWSwHCNq1Kn-u5omY2GA8L6rbDJGHT -O work/fin.mp4
gdown -q 1nclc-YnSJqY0QXUB_7JE8Fthctuqk4yB -O work/pt1.mp4
for k in fin pt1; do
  ffprobe -v error -show_entries format=duration -of csv=p=0 work/$k.mp4 > out/raw/$k/duration.txt
  ffmpeg -loglevel error -i work/$k.mp4 -vf "fps=1/8,scale=1280:-2" -q:v 3 out/raw/$k/f%04d.jpg
  montage -label '%t' -pointsize 22 out/raw/$k/f*.jpg -tile 8x -geometry 320x180+2+2 out/raw/$k-sheet.jpg || true
done
ls out/raw/fin | wc -l; ls out/raw/pt1 | wc -l
