// motor holder
//
// motor has radius of '$mr' with flattened sides at '$mh' and length of '$ml'

// NOTE:  some tolerance added 
$mr = 10.7; // 10 mm radius + shrinkage (was 10.7)
$mh = 15.6; // 15 mm height + shrinkage
$ml = 25.0; // 25.0 mm length excluding 'nubs'
$ml2 = 19.5; // 19.5 mm lengh excluding end cap and shaft guide hole 'nub'

$th = 4.0; // overall thickness of plastic around motor
// NOTE:  wall thickness on sides is 1/2 this

// shaft guide hole size
$sh = 3.1;  // 3.1mm radius
$sw = 2;  // 2mm approximate height of guide
$ft = 1;  // 1mm approximate thickness of face
$pt = 1;  // thickness of panel
$pr = 2;  // 2mm appx radius of post
$br = 1;  // 1mm thickness of brace

$sd1 = 0.97 * 2.54 * 1.02 / 2; // shaft radius
$sd2 = 1.1 * 2.54 * 1.02 / 2; // loose shaft radius - physical hole size will be smaller

echo("Shaft radius: ", $sd2, " vs ", $sd1);

// motor shaft extension length
$sl = 10.0; // length of shaft from flat end of motor
$gh = 5.5;  // radius of gear hole



// global accuracy parameters
$fn=32; // number of faces in shape

module face(hh,bb=0)  // bb is the size of the bottom hole relative to the top hole
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
      
      
      translate([$mh/2+$th/2-$pr/4,mrr+$th/2-$pr/4,-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
      translate([-($mh/2+$th/2-$pr/4),mrr+$th/2-$pr/4,-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
      translate([$mh/2+$th/2-$pr/4,-(mrr+$th/2-$pr/4),-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
      translate([-($mh/2+$th/2-$pr/4),-(mrr+$th/2-$pr/4),-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
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

// this creates a bounding rectangle about the inner
// portion of the face, suitable for a cutaway
module face_boundary(hh,bb=0)  // bb is the size of the bottom hole relative to the top hole
{
  mrr = $mr + bb;  
  difference()
  {
      linear_extrude(height=hh)
        square([$mh + bb + $th/2, mrr * 2 + $th/2], true);

      translate([$mh/2+$th/2-$pr/4,mrr+$th/2-$pr/4,-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
      translate([-($mh/2+$th/2-$pr/4),mrr+$th/2-$pr/4,-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
      translate([$mh/2+$th/2-$pr/4,-(mrr+$th/2-$pr/4),-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
      translate([-($mh/2+$th/2-$pr/4),-(mrr+$th/2-$pr/4),-1])
        linear_extrude(height=hh+2)
          square([$pr,$pr],true);
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
            linear_extrude(height=$ml2-$sw+$ft*2)
              circle($pr);

          translate([-$mh/2,$mr,0])
            linear_extrude(height=$ml2-$sw+$ft*2)
              circle($pr);

          translate([$mh/2,-$mr,0])
            linear_extrude(height=$ml2-$sw+$ft*2)
              circle($pr);

          translate([$mh/2,$mr,0])
            linear_extrude(height=$ml2-$sw+$ft*2)
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

$mp = 27; // motor position (offset)
$ll = 85; // length of holder
$ww = 30; // width of holder
$fd = 1.5; // distance of hole from edge in mm
$ff = $xd/2+$fd;  // offset of hole center from edge (appx 1/8" hole, appx 1/16" plastic around it)
$gt = 0.15;     // gear tolerance (mm)

$bs = 5; // 5mm bushing height
$bd = 3; // 6mm bushing diameter

//rotate(a=[0,0,0])
//  motor_holder();

color("orange")
  difference()
  {
    dx=$ll/2-$ff;
    dy=$ww/2-$ff;

    union()
    {
//      difference()
//      {
        translate([$mp,0,0])
          linear_extrude(height=$pt)
            square([$ll,$ww],true);

//        translate([0,0,$ft])
//          face_boundary($sw,-0.3);
//      }

      // perimeter braces
      translate([$mp,-$ww/2+$br/2,0])
        linear_extrude(height=$br+$pt)
          square([$ll,$br],true);
      translate([$mp,$ww/2-$br/2,0])
        linear_extrude(height=$br+$pt)
          square([$ll,$br],true);

      translate([$mp-$ll/2+$br/2,0,0])
        linear_extrude(height=$br+$pt)
          square([$br,$ww],true);
      translate([$mp+$ll/2-$br/2,0,0])
        linear_extrude(height=$br+$pt)
          square([$br,$ww],true);

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

      // bushing supports
      translate([$mp,0,0])
        linear_extrude(height=$br+$pt)
          square([$ll,$br],true);
      translate([2*(3.175+14.1652+$gt),0,0])
        linear_extrude(height=$pt+$br)
          square([$br,$ww],true);

      // bracing the screw holes
      translate([$mp-dx,-dy,0])
        linear_extrude(height=$pt+$br)
          circle(d=$xd+$fd*2);
      translate([$mp-dx,dy,0])
        linear_extrude(height=$pt+$br)
          circle(d=$xd+$fd*2);
      translate([$mp+dx,-dy,0])
        linear_extrude(height=$pt+$br)
          circle(d=$xd+$fd*2);
      translate([$mp+dx,dy,0])
        linear_extrude(height=$pt+$br)
          circle(d=$xd+$fd*2);

    }

//    translate([0,0,-1])
//      linear_extrude(height=$sw+2)
//        circle($gh);

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

    // mount holes
    translate([$mp-dx,-dy,-1])
      linear_extrude(height=$pt+$br+2)
        circle(d=$xd);
    translate([$mp-dx,dy,-1])
      linear_extrude(height=$pt+$br+2)
        circle(d=$xd);
    translate([$mp+dx,-dy,-1])
      linear_extrude(height=$pt+$br+2)
        circle(d=$xd);
    translate([$mp+dx,dy,-1])
      linear_extrude(height=$pt+$br+2)
        circle(d=$xd);
  }
  

  if(0)
  {
    dx=$ll/2-$ff;
    dy=$ww/2-$ff;
    xxd=$xd * 1.5;
    color("purple")
    {
      translate([3*(3.175+14.1653+$gt), 0, $pt])
        linear_extrude(height=.1)
          circle(14.1653);

      translate([$mp-dx,-dy,-1])
        linear_extrude(height=$pt+2)
          polygon([[-xxd/2,0],[-xxd/4,xxd/2],
                  [xxd/4,xxd/2],[xxd/2,0],
                  [xxd/4,-xxd/2],[-xxd/4,-xxd/2]]);

      translate([$mp-dx,dy,-1])
        linear_extrude(height=$pt+2)
          polygon([[-xxd/2,0],[-xxd/4,xxd/2],
                  [xxd/4,xxd/2],[xxd/2,0],
                  [xxd/4,-xxd/2],[-xxd/4,-xxd/2]]);


      translate([$mp+dx,-dy,-1])
        linear_extrude(height=$pt+2)
          polygon([[-xxd/2,0],[-xxd/4,xxd/2],
                  [xxd/4,xxd/2],[xxd/2,0],
                  [xxd/4,-xxd/2],[-xxd/4,-xxd/2]]);

      translate([$mp+dx,dy,-1])
        linear_extrude(height=$pt+2)
          polygon([[-xxd/2,0],[-xxd/4,xxd/2],
                  [xxd/4,xxd/2],[xxd/2,0],
                  [xxd/4,-xxd/2],[-xxd/4,-xxd/2]]);
    }
  }


