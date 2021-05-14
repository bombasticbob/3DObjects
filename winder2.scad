// hand crank stand for coil winder
// need 2 of these

$sd = 25.4/2    // 1/2 inch diameter shaft
    + 25.4/32;  // add 1/32 inch clearance
                       
$th = 2;      // 2mm thickness of braces
$th2 = 1;     // 1mm thickness of 'filler'

$wd = 70;     // 70mm diameter wheel
$hh = $wd/2+$sd/2+25.4/2; // height of 'square' part
$ww = ($sd+$th*2)+$th2*1.8;

$bh = 25.4 / 4; // 1/4" base height

$dd = 25.4/8+0.2; // 1/8 inch diameter hole
//$of = $dd+$wt;    // offset from edge


$fn = 64; // 64 faces on polygons

union()
{
  difference()
  {
    union()
    {
      color("green")
        translate([0,($hh-($sd+$th*2))/2-$th2,0])
          linear_extrude(height=$th2)
            square([$ww,$hh],true);

      color("orange")
        union()
        {
          // lateral braces
          translate([0,-($sd+$th*2)/2,$th2-1])
            linear_extrude(height=$th2+1)
              square([$ww,$th],true);

          translate([0,($sd+$th*2)/2,$th2-1])
            linear_extrude(height=$th2+1)
              square([$ww,$th2],true);

          // base
          translate([0,$hh-$th2-($sd+$th*2)/2,
                     $th2-1])
            linear_extrude(height=$th2+1+$bh)
              square([$ww,$th2],true);

          translate([0,
                     $hh-$th2*2-($sd+$th*2)/2,
                     $th2+$bh])
            linear_extrude(height=$th2)
              square([$ww,$th2*2],true);

          translate([0,
                     $hh-$th2*2-($sd+$th*2)/2,
                     $th2-1])
            linear_extrude(height=$th2+1)
              square([$ww,$th2*2],true);

          translate([-$ww/2+$th2/2,
                     $hh-$th2*2-($sd+$th*2)/2,
                     $th2-1])
            linear_extrude(height=$th2+1+$bh)
              square([$th2,$th2*2-0.1],true);

          translate([$ww/2-$th2/2,
                     $hh-$th2*2-($sd+$th*2)/2,
                     $th2-1])
            linear_extrude(height=$th2+1+$bh)
              square([$th2,$th2*2-0.1],true);

          // center base brace
          translate([0,
                     $hh-$th2*2-($sd+$th*2)/2,
                     $th2-1])
            linear_extrude(height=$th2+1+$bh)
              square([$th2,$th2*2-0.1],true);

          // mounting screw holes
          translate([-$ww/4,
                     $hh-$th2-($sd+$th*2)/2,
                     $th2-1])
            rotate([90,0,0])
              translate([0,$bh-$dd/2+$th2,0])
                linear_extrude(height=$th2*2)
                  circle(d=$dd+$th);

          translate([$ww/4,
                     $hh-$th2-($sd+$th*2)/2,
                     $th2-1])
            rotate([90,0,0])
              translate([0,$bh-$dd/2+$th2,0])
                linear_extrude(height=$th2*2)
                  circle(d=$dd+$th);

          // longitudinal braces
          translate([-$ww/2+$th2/2,
                     -($sd+$th*2-$hh)/2
                       -$th2/2,
                     $th2-1])
            linear_extrude(height=$th2+1)
              square([$th2,$hh-$th2],true);

          translate([$ww/2-$th2/2,
                    -($sd+$th*2-$hh)/2
                      -$th2/2,
                    $th2-1])
            linear_extrude(height=$th2+1)
              square([$th2,$hh-$th2],true);

          // diagonal braces
          translate([0,($sd+$th*2)/2+$hh/12,
                     $th2-1])
            linear_extrude(height=$th2+1)
              polygon([[$ww/2,0],[$ww/2,$th2*2],
                       [-$ww/2,$hh/2+$th2*2],
                       [-$ww/2,$hh/2]]);

          translate([0,($sd+$th*2)/2+$hh/12,
                     $th2-1])
            linear_extrude(height=$th2+1)
              polygon([[-$ww/2,0],
                       [-$ww/2,$th2*2],
                       [$ww/2,$hh/2+$th2*2],
                       [$ww/2,$hh/2]]);
 
          

        }

      color("blue")
        linear_extrude(height=$th*2)
          circle(d=($sd+$th*2));
    }

    color("yellow")
      translate([0,0,-1])
        linear_extrude(height=$th*2+2)
          circle(d=$sd);

          // mounting screw holes
    color("yellow")
          translate([-$ww/4,
                     $hh-$th2-($sd+$th*2)/2+1,
                     $th2-1])
            rotate([90,0,0])
              translate([0,$bh-$dd/2+$th2,0])
                linear_extrude(height=$th2*2+2)
                  circle(d=$dd);

    color("yellow")
          translate([$ww/4,
                     $hh-$th2-($sd+$th*2)/2+1,
                     $th2-1])
            rotate([90,0,0])
              translate([0,$bh-$dd/2+$th2,0])
                linear_extrude(height=$th2*2+2)
                  circle(d=$dd);
  }

  // base

  

}

