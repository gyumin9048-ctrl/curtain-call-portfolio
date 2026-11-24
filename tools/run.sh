#!/usr/bin/env bash
# Pass 9: escape-route captures from final build video frames (raw branch)
set -euo pipefail
pip install -q pillow
mkdir -p work out/main/assets
git fetch -q --depth 1 origin +raw:refs/remotes/origin/raw
git show origin/raw:fin/f0579.jpg > work/gather.jpg
git show origin/raw:fin/f0576.jpg > work/door.jpg
python3 - <<'P'
from PIL import Image
for src,dst in [('work/gather.jpg','play-escape-open.webp'),('work/door.jpg','play-escape-door.webp')]:
    im=Image.open(src).convert('RGB')
    if im.width>1280: im=im.resize((1280,round(im.height*1280/im.width)),Image.LANCZOS)
    im.save('out/main/assets/'+dst,quality=80,method=6)
P
ls -la out/main/assets
