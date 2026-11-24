#!/usr/bin/env bash
# Pass 1: raw captures for review (pushed to branch "raw", not to the site)
set -euo pipefail
mkdir -p work out/raw/video out/raw/cut out/raw/guide
dl(){ gdown -q "$1" -O "$2"; }
dl 171gz08CiTHh53IDAkS_3zTghx7N9p39i work/guide.pdf
pdftoppm -r 50 -jpeg work/guide.pdf out/raw/guide/p
dl 1gKJOqLCXu1OXvTF4W246B0GU2ar7Iuci work/rec1116.mp4
ffprobe -v error -show_entries format=duration -of csv=p=0 work/rec1116.mp4 > out/raw/video/duration.txt
ffmpeg -loglevel error -i work/rec1116.mp4 -vf "fps=1/4,scale=960:-2" -q:v 5 out/raw/video/f_%04d.jpg
for pair in "1xIcRXCU1Sg61PpjssljgoslHqv33K0hG tape" "1LcEyRcO8JV_j8AOGn3bn7Ei5RCsFgj_7 rec1" "1SGWPp8vD512atqkU2HjwFriYSzvqOUif rec2"; do
  set -- $pair; dl "$1" "work/$2.mp4"
  ffmpeg -loglevel error -i "work/$2.mp4" -vf "fps=1/2,scale=960:-2" -q:v 5 "out/raw/cut/$2_%03d.jpg"
done
ls -R out/raw | head -50
