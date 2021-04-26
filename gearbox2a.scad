// motor holder
//
// motor has radius of '$mr' with flattened sides at '$mh' and length of '$ml'

// NOTE:  some tolerance added 
$mr = 10.4; // 10 mm radius + shrinkage (was 10.7)
$mh = 15.8; // 15 mm height + shrinkage
$ml = 25.0; // 25.0 mm length excluding 'nubs'
$ml2 = 19.5; // 19.5 mm lengh excluding end cap and shaft guide hole 'nub'

$th = 4.0; // overall thickness of plastic around motor
// NOTE:  wall thickness on sides is 1/2 this

// shaft guide hole size
$sh = 3.1;  // 3.1mm radius
$sw = 2;  // 2mm approximate height of guide
$ft = 1;  // 1mm approximate thickness of face
$pr = 2;  // 2mm appx radius of post

$sd1 = 0.97 * 2.54 * 1.02 / 2; // shaft radius
$sd2 = 1.01 * 2.54 * 1.02 / 2; // loose shaft radius

// motor shaft extension length
$sl = 10.0; // length of shaft from flat end of motor
$gh = 5.5;  // radius of gear hole



// global accuracy parameters
$fn=32; // number of faces in shape

module face(hh,bb=0)
{
  mrr = $mr + bb;  
    
  union()
  {
    difference()
    {
      linear_extrude(height=hh)
        square([$mh + $th, mrr * 2 + $th], true);

      translate([0,0,-1])
        linear_extrude(height=hh+2)
          polygon(points=[[-$mh/2,-mrr],[$mh/2,-mrr],[$mh/2,mrr],[-$mh/2,mrr]]);
    }

    difference()
    {
      linear_extrude(height=hh)
        polygon(points=[[-$mh/2,-mrr],[$mh/2,-mrr],[$mh/2,mrr],[-$mh/2,mrr]]);

      translate([0,0,-1])
        linear_extrude(height=hh+2)
          circle(mrr);
    }
  }
}

module motor_holder()
{
  translate([0,0,$ft])
    union()
    {
      color("green")  
        face($sw,-0.3);

      color("yellow")
        union()
        {
          translate([-$mh/2,-$mr,0])
            linear_extrude(height=$ml2-$sw+1)
              circle($pr);

          translate([-$mh/2,$mr,0])
            linear_extrude(height=$ml2-$sw+1)
              circle($pr);

          translate([$mh/2,-$mr,0])
            linear_extrude(height=$ml2-$sw+1)
              circle($pr);

          translate([$mh/2,$mr,0])
            linear_extrude(height=$ml2-$sw+1)
              circle($pr);
        }

      color("blue")
        translate([0, 0, $ml2-$sw])
          face($sw,0);
    }

//  color("purple")
//    difference()
//    {
//      linear_extrude(height=$ft)
//        square([$mh + $th, $mr * 2 + $th], true);
  
//      translate([0,0,-1])
//        linear_extrude(height=$ft+2)
//          circle($gh);
//    }
}

//  echo("****************");
//  echo("face is ",$mh+$th," by ", $mr * 2 + $th," (mm)");

//  echo("overall height is ", $ft + $ml2, " (mm)");
//  echo("****************");

$xd = 25.4 / 8 + 0.3; // screw holes

$mp = 25; // motor position (offset)
$ll = 84; // length of holder
$ww = 30; // width of holder
$ff = $xd/2+1;  // offset of hole from edge
$gt = 0.07;     // gear tolerance (mm)

$bs = 5; // 5mm bushing height
$bd = 3; // 6mm bushing diameter

rotate(a=[0,0,0])
  motor_holder();

color("orange")
  difference()
  {
    union()
    {
      translate([$mp,0,0])
        linear_extrude(height=$ft)
          square([$ll,$ww],true);

      // bushings - need to be large, otherwise hole melts
      translate([3.175+14.1652+$gt, 0, 0])
        linear_extrude(height=$ft+$bs)
          circle($bd);
    
      translate([2*(3.175+14.1652+$gt), 0, 0])
        linear_extrude(height=$ft+$bs)
          circle($bd);

      translate([3*(3.175+14.1652+$gt), 0, 0])
        linear_extrude(height=$ft+$bs)
          circle($bd);
    }

    translate([0,0,-1])
      linear_extrude(height=$ft+2)
        circle($gh);

  // from gear_test2
  // gear wheel radius: 0.125 in 3.175 mm
  // Tooth side length: 0.0669041 in 1.69937 mm
  // gear radius: 0.185786 in 4.71897 mm

  // from gear-test4
  // gear wheel radius: 0.4923, in 12.5044 mm
  // Tooth side length: 0.0669012 in 1.69929 mm
  // gear radius: 0.557684 in 14.1652 mm

    translate([3.175+14.1652+$gt, 0,-1])
      linear_extrude(height=$ft+$bs+2)
        circle($sd2);
    
    translate([2*(3.175+14.1652+$gt), 0,-1])
      linear_extrude(height=$ft+$bs+2)
        circle($sd2);

    translate([3*(3.175+14.1652+$gt), 0,-1])
      linear_extrude(height=$ft+$bs+2)
        circle($sd2);

    dx=$ll/2-$ff;
    dy=$ww/2-$ff;

    translate([$mp-dx,-dy,-1])
      linear_extrude(height=$ft+2)
        circle(d=$xd);
    translate([$mp-dx,dy,-1])
      linear_extrude(height=$ft+2)
        circle(d=$xd);
    translate([$mp+dx,-dy,-1])
      linear_extrude(height=$ft+2)
        circle(d=$xd);
    translate([$mp+dx,dy,-1])
      linear_extrude(height=$ft+2)
        circle(d=$xd);
  }
  

//  color("purple")
//    translate([3*(3.175+14.1653+$gt), 0, 1])
//      linear_extrude(height=.1)
//        circle(14.1653);




