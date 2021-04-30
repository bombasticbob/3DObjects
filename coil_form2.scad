// coil form
//
// (inductance to be determined)
//

$sd = 4.2; // 2.8mm slug diameter plus clearance for screw and cap
$sl = 25.4; // 25.4mm (1 inch) slug length
$th = 1.5;  // 1.5mm wall thickness
$bh = 4;    // 4mm base height

$nn = 25.4 / 16; // 1/16 inch notches
$bw = 25.4 * 4 / 10 + $nn;  // 4/10 inch square base for mount holes (add twice notch size for actual base size)
$dr = $nn; // 1/16 drill radius for mount hole


// yoke/canopy dimensions
$xd = 25.4 / 8 + 0.3; // diameter for adjust screw hole
$xc = 25.4 / 4; // clearance above tube for adjust thingy
$xw = 25.4 / 4; // width of adjust thingy
$xl = 25.4 / 4; // length of adjust thingy
$xh = 2;        // thickness of adjust thingy


$fn=32; // num frames in shape (global)

color("red") // base
  difference()
  {
    linear_extrude(height=$bh) // square base
      square($bw+$nn,center=true);
    
    translate([$bw/2 + $nn/4, 0, -1]) // notches
      linear_extrude(height=$bh + 2)
        square($nn, center=true);

    translate([$bw/2 + $nn/4, $bw/4, -1])
      linear_extrude(height=$bh + 2)
        square($nn, center=true);

    translate([$bw/2 + $nn/4, -$bw/4, -1])
      linear_extrude(height=$bh + 2)
        square($nn, center=true);

    translate([-$bw/2 - $nn/4, $bw/4, -1])
      linear_extrude(height=$bh + 2)
        square($nn, center=true);

    translate([-$bw/2 - $nn/4, -$bw/4, -1])
      linear_extrude(height=$bh + 2)
        square($nn, center=true);

    translate([0,0,-1])
      linear_extrude(height=$bh + 2)
        circle(d=$sd);

    translate([$bw/2-$nn/2,$bw/2-$nn/2,-1])
      linear_extrude(height=$bh + 2)
        circle(d=$dr);
    translate([-($bw/2-$nn/2),$bw/2-$nn/2,-1])
      linear_extrude(height=$bh + 2)
        circle(d=$dr);
    translate([$bw/2-$nn/2,-($bw/2-$nn/2),-1])
      linear_extrude(height=$bh + 2)
        circle(d=$dr);
    translate([-($bw/2-$nn/2),-($bw/2-$nn/2),-1])
      linear_extrude(height=$bh + 2)
        circle(d=$dr);
  }

color("orange")
  translate([0,0,$bh-1])
    difference()
    {
      linear_extrude(height=2*$sl+1)
        circle(d=$sd+$th);

      translate([0,0,-1])
        linear_extrude(height=2*$sl+3)
          circle(d=$sd);
      
      translate([0,0,1.6*$sl])
        linear_extrude(height=0.4*$sl+3)
          square([$sd*1.5+$th,$sd*0.7], true);
    }

color("red")   // limit of slug motion
  translate([0,0,$sl+$bh])
    difference()
    {
      linear_extrude(height=$th)
        circle(d=$bw+$th+$nn);

      translate([0,0,-1])
        linear_extrude(height=$th+2)
          circle(d=$sd);

      for(ww=[0:30:359])
      {
        rotate([0,0,ww])
          translate([$bw/2 + $nn, 0, -1]) // notches
            linear_extrude(height=$bh + 2)
              square([2*$nn,$nn], center=true);
      }
        
    }

color("green")   // yoke/canopy thingy for adjustments
  translate([0,0,2*$sl+$bh])
    union()
    {
      translate([0,0,$xc])
        difference()
        {
          linear_extrude(height=$xh)
            square([$xw, $xl+$th], center=true);
          translate([0,0,-1])
            linear_extrude(height=$xh+2)
              circle(d=$xd);
        }

      translate([0,0,-$bh])
        difference()
        {
          union()
          {
            translate([0,$xl/2,0])
              linear_extrude(height=$bh+$xc+$xh)
                square([$xw,$th],center=true);
            translate([0,-$xl/2,0])
              linear_extrude(height=$bh+$xc+$xh)
                square([$xw,$th],center=true);
            linear_extrude(height=$bh-1)
                square([$xw,$xw],center=true);
          }
          translate([0,0,-1])
            linear_extrude(height=$bh+$xc+$xh)
              circle(d=$sd+$th/4);

          translate([0,0,-1])
            linear_extrude(height=0.2*$sl+3)
              square([$sd*1.5+$th,$sd*0.7], true);
        }
    }
    
    