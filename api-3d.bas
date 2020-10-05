option explicit
option base 0

dim ORIGIN(2)=(mm.hres/2,mm.vres/2,-500)
const PROPORTION=mm.vres/mm.hres
const PROJECTION_PLANE=-300

Main()

sub Main
  local float q(4)
  'local float points(2,4)=(-100,-100,-100, 100,-100,-100, 100,100,-100, -100,100,-100, -100,-100,-100)
  local float points(2,15)
  loadPoints(points())

  ' Create quaternion  X,Y,Z axis for rotation
  math q_create rad(0.5),1,1,0,q()

  cls
  do
    ProjectPoints(points(),rgb(black))
    Rotate(points(),q())
    ProjectPoints(points(),rgb(red))
    pause 10
  loop
end sub

sub Rotate(points() as float, q() as float)
  local integer i
  local float v(4), vout(4)
  local resp
  for i=0 to bound(points(),2)
    v(0)=0
    v(1)=points(0,i)
    v(2)=points(1,i)
    v(3)=points(2,i)
    v(4)=0

    math q_rotate q(),v(),vout()
    points(0,i)=vout(1)
    points(1,i)=vout(2)
    points(2,i)=vout(3)

    'print @(0,30) "I: "+str$(i)
    'print @(0,65) "VI: "+str$(v(0))+", "+str$(v(1))+", "+str$(v(2))+", "+str$(v(3))+", "+str$(v(4))+space$(10)
    'print @(0,80) "VO: "+str$(vout(0))+", "+str$(vout(1))+", "+str$(vout(2))+", "+str$(vout(3))+", "+str$(vout(4))+space$(10)
    'input resp
  next
end sub

sub ProjectPoints(points() as float, color as float)
  local integer i
  local float x1,x2,y1,y2,z1,z2

  for i=0 to bound(points(),2)-1
    z1=points(2,i)+ORIGIN(2)
    x1=points(0,i)*PROJECTION_PLANE/-z1*PROPORTION+ORIGIN(0)
    y1=points(1,i)*PROJECTION_PLANE/-z1+ORIGIN(1)
    z2=points(2,i+1)+ORIGIN(2)
    x2=points(0,i+1)*PROJECTION_PLANE/-z2*PROPORTION+ORIGIN(0)
    y2=points(1,i+1)*PROJECTION_PLANE/-z2+ORIGIN(1)
    line x1,y1, x2,y2, 1,color

    'print @(0,545) "i: "+str$(i)
    'Print3dPoint(0,560,points(),i)
    'Print3dPoint(0,575,points(),i+1)
  next
end sub

sub Print3dPoint(x%,y%,points!(),index%)
  print @(x%,y%) "x: "+str$(points!(0,index%))+", y: "+str$(points!(1,index%))+", z: "+str$(points!(2,index%))+space$(10)
end sub

sub LoadPoints(points() as float)
  local integer i,axis
  for i=0 to bound(points(),2)
    for axis=0 to bound(points(),1)
      read points(axis,i)
    next axis
  next i
end sub

data -100,-100,100
data 100,-100,100
data 100,100,100
data -100,100,100
data -100,100,-100
data -100,-100,-100
data -100,-100,100
data -100,100,100
data -100,100,-100
data 100,100,-100
data 100,-100,-100
data 100,-100,100
data 100,100,100
data 100,100,-100
data 100,-100,-100
data -100,-100,-100

