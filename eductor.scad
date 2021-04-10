// eductor
//
// Copyright 2019 by Bob Frazier and S.F.T. Inc.
//
// This program creates a ventury convergent/divergent setup for an eductor


// BEGIN SCAD PROGRAM

function scaler(n) = n * 0.254 * 1.02;
  // convert 1/100 inch to millimeters
  // with 1.02 shrink factor
function anti_scaler(n) = (n / 0.254) / 1.02;

$fr=8;              // focus ratio (bigger number equals skinnier)
$hr=scaler(17.5);   // 4.5mm in 'hundredths of an inch'
$ph=scaler(150);    // 1.5 inches
$fh=$ph/$fr;        // focus height (TODO: eliminate this)
$ww=scaler(100/16);  // wall width, 1/16"
$id=1.5; // 1.5mm min inner diameter

$dy=0.06; // delta Y for loops

// global accuracy parameters
$fn=32; // number of faces in shape

translate([0,$ph,0])//$ph*2+.1])
 rotate(a=[90,0,0])
  union()
  {
      difference()
      {
        color("red") // horn
          for(i0=[-$fr:$dy:$fr/3])
          {
    //          echo("i0/fr=",i0/$fr);
            translate([0,0,$ph-i0*$fh])
              linear_extrude(height=$dy*$fh*1.1)
                circle((i0/$fr)*(i0/$fr)*$fh+$id+$ww);
          }

        color("orange") // horn inside
          for(i2=[-$fr-4*$dy:$dy:$fr/2+4 * $dy])
          {
            translate([0,0,$ph-i2*$fh])
              linear_extrude(height=$dy*$fh*1.1)
                circle((i2/$fr)*(i2/$fr)*$fh+$id);
          }
      }

      difference()
      {
        color("red") // horn flange
            translate([0,0,$ph+$fr*$fh-$ww+$fh*$dy])
              linear_extrude(height=$ww)
                scale([1.4,0.9])
                  circle($fh+$id+$ww*2);
        color("orange") // horn flange inside
            translate([0,0,$ph+$fr*$fh-$ww-1])
              linear_extrude(height=$ww+2)
                circle($fh+$id);

        color("yellow")
            translate([-($fh+$id+$ww*2.5),0,$ph+$fr*$fh-$ww+$fh*$dy-1])
              linear_extrude(height=$ww+2)
                circle(1.35);
        color("yellow")
            translate([($fh+$id+$ww*2.5),0,$ph+$fr*$fh-$ww+$fh*$dy-1])
              linear_extrude(height=$ww+2)
                circle(1.35);
      }

      difference()
      {
          color("green") // manifold
            translate([0,-$id*3-$ww*2-1,$ww*9+$fr])
              rotate(a=[-90,0,0])
                linear_extrude(height=$id*5+$ww*4+1)
                  circle($ww * 4);

          color("blue") // manifold inside
            translate([0,-$id*3-$ww*3-1,$ww*9+$fr])
              rotate(a=[-90,0,0])
                linear_extrude(height=$id*5+$ww*3+1)
                  circle($ww * 3);

        color("purple") // manifold nozzle hole
          translate([0,0,$fh+$ww*2-1])
            linear_extrude(height=$fh*2+3)
              circle(1);

        color("purple") // manifold horn hole
          translate([0,0,$ph-$fh/2*$fr+1])
            linear_extrude(height=$fh*2+3)
              circle(3);
      }

      difference()
      {
          color("green") // manifold flange
            translate([0,-$id*3-$ww*3,$ww*9+$fr])
              rotate(a=[-90,0,0])
                linear_extrude(height=$ww)
                  circle($ww * 5 + 3);

          color("blue") // flange inside
            translate([0,-$id*3-$ww*4,$ww*9+$fr])
              rotate(a=[-90,0,0])
                linear_extrude(height=$ww+2)
                  circle($ww * 3);

          color("orange") // flange bolt holes
            translate([0,-$id*3-$ww*3,$ww*9+$fr])
              rotate(a=[-90,0,0])
                for(i1=[45:90:315])
                {
                  rr=$ww * 4.5 + 1.5;
                  xx = rr * cos(i1);
                  yy = rr * sin(i1);
                  translate([xx,yy,-1])
                    linear_extrude(height=$ww+2)
                      circle(1.35);
                }
      }

      difference()
      {
        color("yellow") // inlet nozzle
          translate([0,0,$fh+$ww*2])
            linear_extrude(height=$fh*2+$ww)
              circle(25.4/16);//1+$ww/2);
// note inlet nozzle pipe is 1/8" in diameter

        color("purple") // nozzle inside
          translate([0,0,$fh+$ww*2-2])
            linear_extrude(height=$fh*2+$ww+8)
              circle(1);
      }

      // hose ridge rings on outside of nozzle
      color("yellow") 
        for(nn=[2*$fh-$ww/2:$ww:2*$fh+$ww*2.5])
        {
          difference()
          {
            for(aa=[0:$ww/20:$ww/2])
              translate([0,0,nn+aa])
                linear_extrude(height=$ww/20)
                  circle(25.4/16+aa*2/3);

            translate([0,0,nn-1])
              linear_extrude(height=$ww/2+2)
                circle(25.4/16-0.5);
          }
        }

    };
