// Wheel with a mating surface to a gear pressed onto a stepper motor
//
// Copyright 2018,2019 by Bob Frazier and S.F.T. Inc.
//
// There is no restriction as to how this file can be used


function scaler(n) = n * 0.254 * 1.02;
  // convert 1/100 inch to millimeters
  // with 1.02 shrink factor
function anti_scaler(n) = (n / 0.254) / 1.02;

$gd=scaler(19)/2; // 0.19" 'gear' diam (inside)

$gh=scaler(16);  // 0.10" 'gear' height

$od=scaler(100)/2; // outer wheel diameter

$tc=10; // number of gear teeth

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

  h2=scaler(4);
  h1=h-h2;

  if(n == 0)
  {
    // echo out the various tooth sizes as
    // calculated.  it's a bit easier to
    // tweek things to match using the
    // gear diameter so that gear teeth
    // will mesh.
    echo("gear wheel radius: ", anti_scaler(r));
    echo("Tooth side length: ", anti_scaler(ah));
    echo("gear radius:  ", anti_scaler(sqrt(cx3*cx3+cy3*cy3)));
  }

  union()
  {
    color("blue")
      translate([0,0,0])
        linear_extrude(height=h1, scale=1)
          polygon(points=[[cx1,cy1],[cx2,cy2],[cx3,cy3]]);

    color("orange")
      translate([0,0,h1])
        linear_extrude(height=h2, center=true , scale=1.15)
          polygon(points=[[cx1,cy1],[cx2,cy2],[cx3,cy3]]);
  }
}

color("red")
  difference()
  {
    translate(0,0,0)
      linear_extrude(height=$gh)
        circle($od, center=true);

    union()
    {
      translate([0,0,-1])
        color("green")
          linear_extrude(height=$gh+scaler(4))
            circle($gd, center=true);

      translate([0,0,$gh+scaler(4)-2])
        color("green")
          linear_extrude(height=scaler(4),scale=1.2)
            circle($gd, center=true);

      for(i=[0:$tc-1])
      {
       translate([0,0,-1])
        tooth($gd,$gh+scaler(8),i,$tc);
      }
    };

  }

