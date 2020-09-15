option explicit

dim integer x, y, velx, vely

const boxsizex = 20
const boxsizey = 25

x=RND * (800 - boxsizex)
y=RND * (600 - boxsizey)

if RND > 0.5 then
  velx=1
else
  velx=-1
endif

if RND > 0.5 then
  vely=1
else
  vely=-1
endif

cls

do
  'box x,y,boxsizex,boxsizey,,RGB(black),RGB(black)
  
  if x = 0 and velx < 0 then
    velx=1
  elseif x=800 - boxsizex and velx > 0 then
    velx=-1
  endif

  if y = 0 and vely < 0 then
    vely=1
  elseif y = 600 - boxsizey and vely > 0 then
    vely=-1
  endif

  x = x + velx
  y = y + vely
 
  box x,y,boxsizex,boxsizey,2,RGB(yellow),RGB(green)

  pause 5
loop

