// coil form
//
// ref:  62 turns, single layer, 28g
//       20uH without core
//       160uH with ferrite core (10mm x ~25mm)
// Ideal:  turns ratio T = 1.5uH/turn for ~100uH
//         at center of adjustment range
//         which is +50%,-80%
//
// 3 layer coil would be appx 800uH
//

$sd = 10.5; // 10mm slug diameter plus clearance
$sl = 25.4; // 25.4mm (1 inch) slug length
$th = 2;    // 2mm wall thickness
$bh = 4;    // 4mm base height

$nn = 25.4 / 16; // 1/16 inch notches
$bw = 25.4 / 2 + $nn;  // 1/2 inch square base for mount holes (add twice notch size for actual base size)
$dr = $nn; // 1/16 drill radius for mount hole


// yoke/canopy dimensions
// This design assumes inner diameter at least twice
// that of the diameter for the adjustment screw
//
// adjust screw:  4-40 1.5 inch nylong screw, 2 nuts, glued in place on yoke
//                (additional nut glued to top of core?)

$xd = 25.4 / 8 + 0.3; // diameter for adjust screw hole
$xc = 25.4 / 4; // clearance above tube for adjust thingy
$xw = 25.4 / 4; // width of adjust thingy
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
            square([$xw, $sd+$th], center=true);
          translate([0,0,-1])
            linear_extrude(height=$xh+2)
              circle(d=$xd);
        }

      translate([0,0,-$bh])
        difference()
        {
          union()
          {
            translate([0,$sd/2,0])
              linear_extrude(height=$bh+$xc+$xh)
                square([$xw,$th],center=true);
            translate([0,-$sd/2,0])
              linear_extrude(height=$bh+$xc+$xh)
                square([$xw,$th],center=true);
          }
          translate([0,0,-1])
            linear_extrude(height=$bh+$xc+$xh)
              circle(d=$sd+$th/4);
        }
    }
    
    