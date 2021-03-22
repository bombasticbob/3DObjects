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

$shd=scaler(9.7)/2; // 0.1" hole diam
// hole is slightly smaller to fit shaft
// gear will have to be tapped or pressed on
$whd=scaler(20)/2; // 0.20" 'wheel' diam
$gd=scaler(125)/2; // 1" 'turbine wheel' diam
$ah=scaler(12.5);   // the height of a turbine blade in inches (0.25)
$bl=scaler(4); // 0.04 inch blade thickness
$bt=30.0; // turbine blade angle

// NOTE:  based on matching 'tooth side length' with mating gear
//        see 'echo' lines, below, for that and related info
$whh=scaler(22); // 0.22" 'wheel' height
$gh=scaler(8);  // 0.16" 'gear' height

$tc=40; // number of gear teeth

// accuracy parameters
$fn=256; // number of faces in shape

module tooth(r,h,ah,n,tot) // r=radius,
{ //        h=heght, n=egment,
  //        tot=total # of segments

  // center of equilateral triangle with
  // a base of 'A' has a delta Y of A/3

  // the chord length 'A' is equal
  // to 2 * r * sin(th / 2)

  th=360 / tot; // theta angle of chord

  rr = r; // so I can adjust it

  cx1=cos((n * th) - th / 2) * rr;
  cy1=sin((n * th) - th / 2) * rr;

  //// get x,y for the 'tip'
  //cx3=(cx1+cx2)/2 + cos(n * th) * ah;
  //cy3=(cy1+cy2)/2 + sin(n * th) * ah;

  if(n == 0)
  {
    // echo out the various tooth sizes as
    // calculated.
    echo("turbine wheel radius: ", anti_scaler(r));
    echo("Turbine blade length: ", anti_scaler(ah));
    echo("turbine stage diameter:  ", anti_scaler(r + ah) * 0.02, "inches");
  }

  color("blue")
    translate([cx1,cy1,0])
    rotate(a=[$bt,0,n * th])
    linear_extrude(height=h, scale=1)
      polygon(points=[[-.1,0],[-.1,$bl],[ah,$bl],[ah,0]]);
 //polygon(points=[[cx1,cy1],[cx2,cy1],[cx2,cy2],[cx2a,cy2]]);

}

union()
{

  color("red")
    difference()
    {
      translate([0,0,0])
        linear_extrude(height=$whh)
          circle($whd, center=true);
      translate([0,0,-1])
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
          circle($whd, center=true);
    }

  for(i=[0:$tc-1])
  {
    translate([0,0,0])
      tooth($gd,$gh,$ah,i,$tc);
  }
}
