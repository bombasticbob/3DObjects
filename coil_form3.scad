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

function scaler(n) = n * 0.254 * 1.02;
  // convert 1/100 inch to millimeters
  // with 1.02 shrink factor
function anti_scaler(n) = (n / 0.254) / 1.02;


$sd = 10.8; // 10mm slug diameter plus clearance
$sl = 50.8; // 50.8mm (2 inch) slug length
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

color("orange")
  translate([0,0,$th-1])
    difference()
    {
      linear_extrude(height=$sl+2)
        circle(d=$sd+$th);

      translate([0,0,-1])
        linear_extrude(height=$sl+4)
          circle(d=$sd);
    }

color("red")   // tie off for wires
  translate([0,0,$sl+$th])
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

