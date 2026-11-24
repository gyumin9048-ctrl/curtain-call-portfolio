#!/usr/bin/env bash
# Pass 7: candidate frames for exploration/escape captures -> raw branch
set -euo pipefail
mkdir -p work out/raw/duo out/raw/m2
gdown -q 1qv7ydknLWTyEDdJ7fCDoa7sfCfsuXXP9 -O work/duo.mp4
gdown -q 1NRLmhDEtP_EYtouB58YGQ2mfPLBAgKzp -O work/m2.mp4
ffprobe -v error -show_entries format=duration -of csv=p=0 work/duo.mp4 > out/raw/duo/duration.txt
ffprobe -v error -show_entries format=duration -of csv=p=0 work/m2.mp4 > out/raw/m2/duration.txt
ffmpeg -loglevel error -i work/duo.mp4 -vf "fps=1/2,scale=960:-2" -q:v 4 out/raw/duo/f%04d.jpg
ffmpeg -loglevel error -i work/m2.mp4 -vf "fps=1/5,scale=960:-2" -q:v 4 out/raw/m2/f%04d.jpg
ls out/raw/duo | wc -l; ls out/raw/m2 | wc -l
