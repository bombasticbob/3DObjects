// coil form
//
// (inductance to be determined)
//

$sd = 5.3; // 3.2mm slug diameter plus clearance for coupling
$sl = 14;   // 14mm (9/16+ inch) slug length
$th = 1;    // 1mm wall thickness
$th2 = 1.5; // 2mm wire tie thickness
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

zz=1; // zero to only print coupling

$fn=32; // num frames in shape (global)

if(zz)
{
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
      linear_extrude(height=$th2)
        circle(d=$bw+$th+$nn);

      translate([0,0,-1])
        linear_extrude(height=$th2+2)
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
} // zz
    
module threads()
{
  difference()
  {
    to=25.4/16+0.2;  // about 1/8"
    ww=25.4/16;      // wall width 1/16"
    bt=0; // 2mm bottom thickness
    ch=25.4/8;  // 1/8" height
    tp=25.4/40;   // thread pitch 1/40"  4-40
    tb=25.4 * 0.04;  // .04" gap from top
    // max diameter 0.1112. 0.0950
    td=25.4 * 0.008; // thread depth 0.008"
    aa=360*4; // total angular thread motion
    dy=0.1; // delta Y for loops
    ii=6; // 6 degrees iteration on thread

    // threads for 4-40

    color("yellow")
         for(i3=[0:ii:aa])
         {
           translate([cos(i3)*to,sin(i3)*to,bt+ch - tb - td - (tp*aa/360) + (tp*i3/360)]) //$ph+scaler(10)+$ww+$ch])
            rotate(a=[90,-90,i3])
              linear_extrude(height=ww*2)
                 //circle($td, center=true);
                 polygon(points=[[-td,0.254], [td,-0.254], [0,1.5*td]]); // equilateral triangle
         }

      difference() // cylinder that is the outer limit of threads
      {
        translate([0,0,bt-1]) // just below position of threads
          linear_extrude(height=ch)
            circle(to+ww+1); // way outside

        translate([0,0,bt]) 
          linear_extrude(height=ch+2)
            circle(to+0.4); // actual outer limit
      };

  }
}

module coupling()
{
// note filament is 0.4, need to set min thick to that.
  to=3.8/2;//25.4/16+0.2; // about 1/8"
  ch0=25.4/10;  // 1/10" height of threaded part
  ch=25.4/4; // 1/4" height (overall)
  wt=0.6; // 1.5 times filament size
  wd=0.2; // diameter shrink on hole (drill out)

  union()
  {
    threads();
  }

  color("blue")
    difference()
    {
      linear_extrude(ch)
        circle(to+wt); // add wall thickness

      translate([0,0,-1])
        linear_extrude(ch0+2)
          circle(to);

      translate([0,0,ch0-1])
        linear_extrude(ch+2-ch0)
          circle(to-wd);

      translate([-(ch0+1),0,ch0+ch/2])
      {
        rotate([90,0,90])
          linear_extrude(height=ch+2)
            square([1,ch],center=true);
      }
    }

}

if(zz)
  translate([0,0,2*$sl+$bh+$xc])
    threads();

translate([-20,0,0])
  coupling();

translate([20,0,0])
  coupling();