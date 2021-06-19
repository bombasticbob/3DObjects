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

zzz = 1; // 0 to only print caps and clamps

if(zzz != 0) union()
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
    to=25.4/16+0.2;  // about 1/8" diameter (as radius)
    dia=25.4/4;      // 1/4" outer diameter
    ww=dia/2-to;    // wall width ~3/64"
    bt=2; // 2mm bottom thickness
    ch=25.4/8;  // 1/8" height
    tp=25.4/40;   // thread pitch 1/40"  4-40
    tb=25.4 * 0.04;  // .04" gap from top
    // max diameter 0.1112. 0.0950
    td=25.4 * 0.010; // thread depth 0.010" (was 0.008")
    aa=360*4; // total angular thread motion
    dy=0.1; // delta Y for loops
    ii=6; // 6 degrees iteration on thread

    color("magenta")
      difference()
      {
        translate([0,0,bt-1]) // position of bottle cap ring
          linear_extrude(height=ch)
            circle(to+ww);

        translate([0,0,bt]) // position of bottle cap ring
          linear_extrude(height=ch+1)
            circle(to);
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

module clamp()
{
  // from end_cap()
  to=25.4/8+0.2;  // about 1/8" with some slop
  dia=25.4/4;     // 1/4" diameter
  bt=2;           // 2mm bottom thickness
  ch=25.4/8       // 1/8" height of threaded cap
    +0.4;         // plus some extra

  ww=25.4/2; // 1/2" wide
  hh=3.5;    // 3.5mm height
  th=1.0;    // 1mm thick

  union() translate([0,-ww/2,0])
  {
    color("green")
    {
      difference()
      {
        translate([0,0,0])
          linear_extrude(height=th)
            square([ch, ww],false);

        hz=dia*3/4;

        translate([0,ww/2-hz/2,-1])
          linear_extrude(height=th+2)
            square([ch, hz]);
      }
    
      translate([0,ww/2+dia/2+0.1,0])
        linear_extrude(height=hh+th)
          square([ch, th]);
      translate([0,ww/2-th-dia/2-0.1,0])
        linear_extrude(height=hh+th)
          square([ch, th]);

      translate([-th,0,0])
        linear_extrude(height=hh+0.1)
          square([th, ww]);

      translate([-hh,0,hh])
        linear_extrude(height=th)
          square([hh, ww]);

      difference()
      {
        translate([ch,0,0])
          linear_extrude(height=hh+0.1+th)
            square([th, ww]);

        translate([ch-0.1,ww/2-to/2,th])
          linear_extrude(height=hh+th+0.1)
            square([th+0.2, to]);
      }
    }
  }

}

module thingies(zzzz)
{
  xxx=(zzzz != 0) ? 20 : 10;
  yyy=(zzzz != 0) ? 30 : 10;
  rrr=(zzzz != 0) ? 36 : 0;

  translate([-yyy,-xxx,0])
    end_cap();
  translate([-yyy,xxx,0])
    end_cap();

  translate([yyy,xxx,0])
    rotate(a=[0,0,rrr])
      clamp();
  translate([yyy,-xxx,0])
    rotate(a=[0,0,-rrr])
      clamp();
}


thingies(zzz);
