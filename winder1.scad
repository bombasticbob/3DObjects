// hand crank base for coil winder
//

$sd = 25.4/2; // 1/2 inch diameter shaft
$sl = 25.4;   // 1 inch shaft length
$th = 2;      // 2mm thickness of shaft

$wt = 1;      // 1mm thickness of wheel
$wd = 70;     // 70mm diameter

$dd = 25.4/8+0.2; // 1/8 inch diameter hole
$of = $dd+$wt;    // offset from edge

$fn = 64;     // 64 faces on shapes

union()
{
  difference()
  {
    union()
    {
      color("blue")
        linear_extrude(height=$wt)
          circle(d=$wd);

      color("green")
        translate([($wd-$of-$dd)/2,0,0])
            linear_extrude(height=$wt*2)
              circle(d=$dd+$wt*3);

      color("orange")
        translate([0,0,$wt-0.1])
          union()
          {
            difference()
            {
              linear_extrude(height=$wt+0.1)
                circle(d=$wd);

              linear_extrude(height=$wt+0.1)
                circle(d=$wd-$wt*2);
            }

            difference()
            {
              linear_extrude(height=$wt+0.1)
                circle(d=$wd/2+$sd/2);

              linear_extrude(height=$wt+0.1)
                circle(d=$wd/2+$sd/2-$wt*2);
            }

            for(ii=[0:45:359])
            {
              rotate([0,0,ii])
                linear_extrude(height=$wt+0.1)
                  square([$wd,$wt],true);
            }              
          }

      color("red")
        union()
        {
          linear_extrude(height=$wt+$th)
            circle(d=($sd+$th));

          linear_extrude(height=$sl)
            circle(d=$sd);
        }
    }

    color("yellow")
        translate([0,0,-1])
          linear_extrude(height=$sl+2)
            circle(d=($sd-$th));

    color("green")
      translate([0,0,$sl-$th])
        linear_extrude(height=$th+1)
          square([$th,$sd],true);

    color("blue")
      translate([($wd-$of-$dd)/2,0,-1])
          linear_extrude(height=$wt*2+2)
            circle(d=$dd);

  }
}

