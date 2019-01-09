// water bottle cap
//
// Copyright 2019 by Bob Frazier and S.F.T. Inc.
//


// BEGIN SCAD PROGRAM

function scaler(n) = n * 0.254 * 1.02;
  // convert 1/100 inch to millimeters
  // with 1.02 shrink factor
function anti_scaler(n) = (n / 0.254) / 1.02;

// bottle cap 1-27/32" inside thread, 1-7/8 inside of cap
// 1/8" pitch, 370 degrees, inside height btwn 3/8" and 13/32"
// thread diameter 1/32" (approximately)

$to=scaler(187.5)/2;   // 1.12" outer diameter on threaded part
$ww=scaler(100/32);  // wall width, 1/32"
$ch=scaler(300/8);   // 3/8" bottle cap height
$tp=scaler(100/8);   // thread pitch 1/8"
$tb=scaler(300/32);  // 3/32" gap from top
$td=scaler(100/34); // thread diameter
$dy=0.1; // delta Y for loops

// accuracy parameters
$fn=48; // number of faces in shape

  union()
  {
    color("red")
      translate([0,0,0]) // top of bottle cap
        linear_extrude(height=$ww+1)
          circle($to+$ww, center=true);

    color("magenta")
      difference()
      {
        translate([0,0,$ww-1]) // position of bottle cap ring
          linear_extrude(height=$ch)
            circle($to+$ww, center=true);

        translate([0,0,$ww-1]) // position of bottle cap ring
          linear_extrude(height=$ch+2)
            circle($to, center=true);
      };

    // threads on bottle cap - a bit hackish but it works

    color("yellow")
         for(i3=[0:3:370])
         {
           translate([cos(i3)*$to,sin(i3)*$to,$ww+$ch - $tb - $td - $tp*i3/360]) //$ph+scaler(10)+$ww+$ch])
            rotate(a=[90,-90,i3])
              linear_extrude(height=$ww*2, center=true)
                 circle($td, center=true);
         }

  };

