import glob
from PIL import Image
A='out/main/assets/'
def save(im,name,w=None,q=82):
    im=im.convert('RGB')
    if w and im.width>w: im=im.resize((w,round(im.height*w/im.width)),Image.LANCZOS)
    im.save(A+name+'.webp',quality=q)
def page(prefix,n):
    f=sorted(glob.glob(f'work/{prefix}-*{n}.png'))
    f=[x for x in f if x.rsplit('-',1)[1].lstrip('0')==f'{n}.png']
    return Image.open(f[0])
box=(0.0856,0.244,0.9144,0.5749)
for p,name in [(2,'m1g-rope'),(4,'m1g-title'),(9,'m1g-piggy'),(11,'m1g-cannon'),(13,'m1g-catch'),(14,'m1g-injury'),(15,'m1g-waiting')]:
    im=Image.open(glob.glob(f'work/g{p}-*.png')[0]); W,H=im.size
    save(im.crop((int(box[0]*W),int(box[1]*H),int(box[2]*W),int(box[3]*H))),name,960)
for n in range(1,8): save(page('cp',n),f'team-concept-p{n}',1100)
for n in range(1,5): save(page('ms',n),f'team-m1scope-p{n}',1100)
for n in range(1,12): save(page('id',n),f'team-idea-{n:02d}',1100)
for f,name in {'0037':'vid-reh-balance','0052':'vid-reh-piggyback','0484':'vid-practice-free','0094':'vid-perf-rope','0220':'vid-perf-swing','0229':'vid-perf-saw','0421':'vid-perf-cannon','0430':'vid-perf-clear','0199':'vid-chase','0148':'vid-graffiti3','0565':'vid-run-result','0193':'vid-vent-break','0337':'vid-piggyback'}.items():
    save(Image.open(f'work/v/f_{f}.jpg'),name,q=82)
