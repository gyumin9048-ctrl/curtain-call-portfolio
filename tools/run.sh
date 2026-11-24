#!/usr/bin/env bash
# Pass 4: ending screenshot -> assets/ending-duo-success.webp
set -euo pipefail
pip install -q pillow
mkdir -p work out/main/assets
gdown -q 10lxUlPIv9DKIxd3Mc4aNN7S7cqbPzL_2 -O work/end.png
python3 -c "from PIL import Image; im=Image.open('work/end.png').convert('RGB'); w=800; im=im.resize((w,round(im.height*w/im.width)),Image.LANCZOS); im.save('out/main/assets/ending-duo-success.webp',quality=70,method=6)"
ls -la out/main/assets
