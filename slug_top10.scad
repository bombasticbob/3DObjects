// slug top - 10mm slug top
//
// mates to 4-40 screw
//
function scaler(n) = n * 0.254 * 1.02;
  // convert 1/100 inch to millimeters
  // with 1.02 shrink factor
function anti_scaler(n) = (n / 0.254) / 1.02;

// bottle cap 1-27/32" inside thread, 1-7/8 inside of cap
// 1/8" pitch, 370 degrees, inside height btwn 3/8" and 13/32"
// thread diameter 1/32" (approximately)

$to=scaler(12.6)/2;  // about 1/8"
$ww=9.5/2 - $to;  // wall width for 9.5mm
$bt=1; // 1mm bottom thickness
$ch=scaler(12.5);  // 1/8" height
$tp=scaler(100/40);   // thread pitch 1/40"  4-40
$tb=scaler(4);  // .04" gap from top
// max diameter 0.1112. 0.0950
$td=scaler(0.8); // thread depth 0.008"
$aa=360*4; // total angular thread motion
$dy=0.1; // delta Y for loops
$ii=6; // 3 degrees iteration on thread

// accuracy parameters
$fn=30; // number of faces in shape

  union()
  {
    color("red")
      translate([0,0,0]) // top of bottle cap
        linear_extrude(height=$bt)
          circle($to+$ww, center=true);

    color("magenta")
      difference()
      {
        translate([0,0,$bt-1]) // position of bottle cap ring
          linear_extrude(height=$ch)
            circle($to+$ww, center=true);

        translate([0,0,$bt]) // position of bottle cap ring
          linear_extrude(height=$ch+1)
            circle($to, center=true);
      };

    // threads on bottle cap - a bit hackish but it works

    color("yellow")
         for(i3=[0:$ii:$aa])
         {
           translate([cos(i3)*$to,sin(i3)*$to,$bt+$ch - $tb - $td - ($tp*$aa/360) + ($tp*i3/360)]) //$ph+scaler(10)+$ww+$ch])
            rotate(a=[90,-90,i3])
              linear_extrude(height=$ww*2, center=true)
                 //circle($td, center=true);
                 polygon(points=[[-$td,scaler(1)], [$td,-scaler(1)], [0,1.5*$td]], $center=true); // equilateral triangle
         }

  };

