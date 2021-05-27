// hand crank base for coil winder
//

$sd = 25.4/2  // 1/2 inch diameter shaft
    + 0.2;    // a little extra
$th = 2;      // 2mm thickness of shaft

$wt = 1;      // 1mm thickness of wheel
$wd = 60;     // 70mm diameter

$dd = 25.4/8+0.2;  // 1/8 inch diameter hole
$dh = $dd * 2;//25.4/4+0.5;  // 1/4" bracket
//$of = $dd+$wt; // offset from edge

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

//            linear_extrude(height=$wt+0.2)
//              circle(d=($sd+$th));

            for(ii=[0:45:359])
            {
              rotate([0,0,ii])
                linear_extrude(height=$wt+0.1)
                  square([$wd,$wt],true);
            }              
          }

          color("green")
            difference()
            {
              translate([0,0,$wt*2])
                linear_extrude(height=$wt+0.1)
                  circle(d=($wd/2+$sd/2));

              translate([0,0,$wt-0.1])
                linear_extrude(height=$wt*2+1.2)
                  square([$wd/2,$dd],true);
            }

          color("purple")
            translate([$wd/4+$sd/4-$th/2,
                       0,$wt*2])
              difference()
              {
                linear_extrude(height=$dh)
                  square([$th,$dd*2], true);

//                translate([-1,0,$dh/2])
                translate([-2,0,$dh-$dd/2-$th/2])
                  rotate([0,90,0])
                    linear_extrude(height=
                                   $th*2+2)
                      circle(d=$dd);
              }

          color("purple")
            translate([-$wd/4-$sd/4+$th/2,
                       0,$wt*2])
              difference()
              {
                linear_extrude(height=$dh)
                  square([$th,$dd*2], true);

                translate([-2,0,$dh-$dd/2-$th/2])
                  rotate([0,90,0])
                    linear_extrude(height=
                                   $th*2+2)
                      circle(d=$dd);
              }
    }

    color("yellow")
        translate([0,0,-1])
          linear_extrude(height=$wt*2+1.1)
            circle(d=($sd));

}
  color("red")
    translate([0,0,0])
      linear_extrude(height=$th)
        square([$sd+0.1,$th-0.1],true);

}

module end_cap()
{
  union()
  {
    to=25.4/16+0.2;  // about 1/8"
    ww=25.4/16;      // wall width 1/2"
    bt=2; // 2mm bottom thickness
    ch=25.4/8;  // 1/8" height
    tp=25.4/40;   // thread pitch 1/40"  4-40
    tb=25.4 * 0.04;  // .04" gap from top
    // max diameter 0.1112. 0.0950
    td=25.4 * 0.008; // thread depth 0.008"
    aa=360*4; // total angular thread motion
    dy=0.1; // delta Y for loops
    ii=6; // 6 degrees iteration on thread

    color("magenta")
      difference()
      {
        translate([0,0,bt-1]) // position of bottle cap ring
          linear_extrude(height=ch)
            circle(to+ww, center=true);

        translate([0,0,bt]) // position of bottle cap ring
          linear_extrude(height=ch+1)
            circle(to, center=true);
      };

    // threads on bottle cap - a bit hackish but it works

    color("yellow")
         for(i3=[0:ii:aa])
         {
           translate([cos(i3)*to,sin(i3)*to,bt+ch - tb - td - (tp*aa/360) + (tp*i3/360)]) //$ph+scaler(10)+$ww+$ch])
            rotate(a=[90,-90,i3])
              linear_extrude(height=ww*2, center=true)
                 //circle($td, center=true);
                 polygon(points=[[-td,0.254], [td,-0.254], [0,1.5*td]]); // equilateral triangle
         }

  }
}

translate([-35,-10,0])
  end_cap();
translate([-35,10,0])
  end_cap();

