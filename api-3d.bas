option explicit
option base 0

' 640x480 
mode 2,8

' 320x200
'mode 3,8

dim float ORIGIN(2)=(mm.hres/2,mm.vres/2,-800)
const PROPORTION=mm.vres/mm.hres
const PROJECTION_PLANE=-400
const RED=rgb(red)
const BLUE=rgb(blue)
const GREEN=rgb(green)
const YELLOW=rgb(yellow)
const BLACK=rgb(black)
const WHITE=rgb(white)

Main()

sub Main
  local float cube(2,15), prism(8,7), plane(2,4)
  local float cube2(2,15), prism2(8,7)
  local float angle
  loadPoints(prism())
  loadPoints(cube())
  loadPoints(plane())

  math scale cube(),1,cube2()
  math scale prism(),1,prism2()

  Translate(cube(),-200,1,0,0)
  Translate(prism(),200,1,0,0)
  Translate(cube2(),-200,0,0,1)
  Translate(prism2(),200,0,0,1)

  angle=25
  Rotate(plane(),angle,0,0,1)
  Rotate(cube(),angle,0,0,1)
  Rotate(prism(),angle,0,0,1)
  Rotate(cube2(),angle,0,0,1)
  Rotate(prism2(),angle,0,0,1)

  angle=1

  page write 1
  cls
  do
    timer=0

    cls

    Rotate(plane(),angle,0,1,0)
    ProjectPoints(plane(),WHITE)

    Rotate(cube(),angle,0,1,0)
    ProjectPoints(cube(),BLUE)

    Rotate(prism(),angle,0,1,0)
    ProjectTriangles(prism(),RED)

    Rotate(cube2(),angle,0,1,0)
    ProjectPoints(cube2(),GREEN)

    Rotate(prism2(),angle,0,1,0)
    ProjectTriangles(prism2(),YELLOW)


    ' Print FPS
    print @(0,0) "Frame time:"+str$(timer,1,1)+"ms","FPS:"+str$(1000/timer,1,0)+space$(5)

    ' Copy the frame to the screen (page 0)
    page copy 1 to 0
  loop
end sub

sub Translate(points() as float, dist as float, x as float, y as float, z as float)
  local float v(2), vout(2)
  local integer i,j

  for i=0 to bound(points(),2)
    for j=0 to bound(points(),1) step 3
      points(j,i)=points(j,i)+dist*x
      points(j+1,i)=points(J+1,i)+dist*y
      points(j+2,i)=points(j+2,i)+dist*z
    next j
  next i
end sub

sub Rotate(points() as float, angle as float, x as float, y as float, z as float)
  local float q(4)
  local integer i,j
  local float v(4), vout(4)

  math q_create rad(angle),x,y,z,q()

  for i=0 to bound(points(),2)
    for j=0 to bound(points(),1) step 3
      v(1)=points(j,i)
      v(2)=points(J+1,i)
      v(3)=points(j+2,i)

      math q_rotate q(),v(),vout()
      points(j,i)=vout(1)
      points(j+1,i)=vout(2)
      points(J+2,i)=vout(3)
    next j
  next i
end sub

sub ProjectTriangles(points() as float, color as float)
  local integer i,j
  local float p1(2),p2(2),p3(2)

  for i=0 to bound(points(),2)
    ProjectPoint(points(0,i),points(1,i),points(2,i),p1())
    ProjectPoint(points(3,i),points(4,i),points(5,i),p2())
    ProjectPoint(points(6,i),points(7,i),points(8,i),p3())
    triangle p1(0),p1(1), p2(0),p2(1), p3(0),p3(1), color ', rgb(100+i*10,0,0)
  next
end sub

sub ProjectPoints(points() as float, color as float)
  local integer i
  local float p1(2),p2(2)

  for i=0 to bound(points(),2)-1
    ProjectPoint(points(0,i),points(1,i),points(2,i),p1())
    ProjectPoint(points(0,i+1),points(1,i+1),points(2,i+1),p2())
    line p1(0),p1(1), p2(0),p2(1), 1,color
  next
end sub

sub ProjectPoint(x as float, y as float, z as float, pout() as float)
  pout(2)=z+ORIGIN(2)
  pout(0)=x*PROJECTION_PLANE/(-pout(2))*PROPORTION+ORIGIN(0)
  pout(1)=-y*PROJECTION_PLANE/(-pout(2))+ORIGIN(1)
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

' Prism faces
data 0,-100,0, -100,0,-100, -100,0,100
data 0,-100,0, -100,0,100, 100,0,100
data 0,-100,0, 100,0,100, 100,0,-100
data 0,-100,0, 100,0,-100, -100,0,-100
data 0,100,0, -100,0,-100, -100,0,100
data 0,100,0, -100,0,100, 100,0,100
data 0,100,0, 100,0,100, 100,0,-100
data 0,100,0, 100,0,-100, -100,0,-100
 

' Cube points
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

' Plane points
data -310,100,-310
data 310,100,-310
data 310,100,310
data -310,100,310
data -310,100,-310

