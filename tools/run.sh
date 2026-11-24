#!/usr/bin/env bash
# Pass 6: re-render the 4 redesigned planning PDFs -> assets/wp/<key>-NN.webp, merge manifest.json
set -euo pipefail
pip install -q pillow
mkdir -p work out/main/assets/wp
docs="m2wait:17gKEfhgm_MMZrmPLcJc0FM3vXus69YbH
space:1Ip1-5IyLSWsyj4D2h7zZkoxPt7nkgqJp
rehearsal:1Oex8IXuVSPXGlsHruppI09VSn9nLocTQ
asset:1IM7VsC7H6TWg150eUz73wkpFcGCIKcYs"
echo "$docs" | while IFS=: read key id; do
  gdown -q "$id" -O "work/$key.pdf"
  mkdir -p "work/$key"
  pdftoppm -r 130 -png "work/$key.pdf" "work/$key/p"
  rm -f assets/wp/$key-*.webp
done
python3 - <<'P'
import glob,json,os,re
from PIL import Image
man=json.load(open('assets/wp/manifest.json'))
for d in sorted(glob.glob('work/*/')):
    key=os.path.basename(d.rstrip('/'))
    files=sorted(glob.glob(d+'p-*.png'),key=lambda f:int(re.findall(r'(\d+)\.png$',f)[0]))
    out=[]
    for i,f in enumerate(files,1):
        im=Image.open(f).convert('RGB')
        if im.width>1100: im=im.resize((1100,round(im.height*1100/im.width)),Image.LANCZOS)
        name=f'{key}-{i:02d}.webp'
        im.save('out/main/assets/wp/'+name,quality=78,method=6)
        out.append(name)
    man[key]=out
json.dump(man,open('out/main/assets/wp/manifest.json','w'),indent=1)
print({k:len(v) for k,v in man.items()})
P
