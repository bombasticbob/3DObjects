// build a gear with a 0.1" shaft hole
//
// Copyright 2018,2019 by Bob Frazier and S.F.T. Inc.
//
// There is no restriction as to how this file can be used
//
//     GEAR example - 40 teeth, ~1 inch diameter
//
// (this gear is intended to mate with the 'gear_test2.scad' gear)


function scaler(n) = n * 0.254 * 1.02;
  // convert 1/100 inch to millimeters
  // with 1.02 shrink factor
function anti_scaler(n) = (n / 0.254) / 1.02;

// NOTE:  for 2mm shaft, use 1.95mm for tight gear, 2.05mm for loose gear [like reduction gear free-spin on shaft]

$shd=scaler(9.7)/2; // 0.1" hole diam
// hole is slightly smaller to fit shaft
// gear will have to be tapped or pressed on
// 0.1" is ~2.5mm

$whd2=scaler(20)/2; // 0.2" separating wheel diameter
$whh2=4; // 4mm separates the gears
$whd=scaler(25)/2; // 0.25" gear2 diam
$gd=scaler(98.46)/2; // 0.969" 'gear' diam
// NOTE:  based on matching 'tooth side length' with mating gear
//        see 'echo' lines, below, for that and related info
$whh=scaler(25) + $whh2 - 1; // 0.25" 'wheel' height plus space between gears minus a mm [to match other gears]
$gh=scaler(8);  // 0.08" 'gear' height

$tc=40; // number of gear teeth
$tc2=10; // tooth count on smaller gear

// accuracy parameters
$fn=256; // number of faces in shape

module tooth(r,h,n,tot) // r=radius,
{ //        h=heght, n=egment,
  //        tot=total # of segments

  // center of equilateral triangle with
  // a base of 'A' has a delta Y of A/3

  // the chord length 'A' is equal
  // to 2 * r * sin(th / 2)

  th=360 / tot; // theta angle of chord
  aa=2 * r * sin(th / 2); // length of chord
  ah=sin(60)*aa; // height of triangle
  cx1=cos((n * th) - th / 2) * r;
  cx2=cos((n * th) + th / 2) * r;
  cy1=sin((n * th) - th / 2) * r;
  cy2=sin((n * th) + th / 2) * r;

  // get x,y for the 'tip'
  cx3=(cx1+cx2)/2 + cos(n * th) * ah;
  cy3=(cy1+cy2)/2 + sin(n * th) * ah;

  if(n == 0)
  {
    // echo out the various tooth sizes as
    // calculated.  it's a bit easier to
    // tweek things to match using the
    // gear diameter so that gear teeth
    // will mesh.
//    echo("gear wheel radius: ", anti_scaler(r));
//    echo("Tooth side length: ", anti_scaler(ah));
//    echo("gear radius:  ", anti_scaler(sqrt(cx3*cx3+cy3*cy3)));

    echo("gear wheel radius: ", anti_scaler(r) / 100.0, " in ", r / 1.02, " mm");
    echo("Tooth side length: ", anti_scaler(ah) / 100.0, " in ", ah / 1.02, " mm");
    od=sqrt(cx3*cx3+cy3*cy3);
    echo("gear radius:  ", anti_scaler(od) / 100.0, " in ", od/1.02, " mm");
  }

  color("blue")
    linear_extrude(height=h)
      polygon(points=[[cx1,cy1],[cx2,cy2],[cx3,cy3]]);

}

union()
{

  color("orange")
    difference()
    {
      translate([0,0,1])
        linear_extrude(height=$gh+$whh2-1)
          circle($whd2, center=true);
      translate([0,0,-1])
        linear_extrude(height=$gh+$whh2+2)
          circle($shd, center=true);
    }

  color("red")
    difference()
    {
      translate([0,0,$gh+$whh2-0.1])
        linear_extrude(height=$whh-$whh2+0.1)
          circle($whd, center=true);
      translate([0,0,$gh-1])
        linear_extrude(height=$whh+2)
          circle($shd, center=true);
    }

  color("green")
    difference()
    {
      translate([0,0,0])
        linear_extrude(height=$gh)
          circle($gd, center=true);
      translate([0,0,-1])
        linear_extrude(height=$whh+2)
          circle($shd, center=true);
    }

  for(i=[0:$tc-1])
  {
    translate([0,0,0])
      tooth($gd,$gh,i,$tc);
  }

  translate([0,0,$whh2+$gh])
    for(i=[0:$tc2-1])
    {
      translate([0,0,0])
        tooth($whd,$whh-$whh2-1,i,$tc2);
    }
}
