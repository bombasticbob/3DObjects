// motor clip for motor holder

// from motor_holder
// NOTE:  some tolerance added 
$mr = 10.7; // 10 mm radius + shrinkage
$mh = 15.8; // 15 mm height + shrinkage
$ml = 25.0; // 25.0 mm length excluding 'nubs'
$ml2 = 19.5; // 19.5 mm lengh excluding end cap and shaft guide hole 'nub'

$th = 4.0; // overall thickness of plastic around motor
$sw = 2;  // 2mm approximate height of guide

// dimensions for butt-end
$br = 5.4 ; // radius of hole for bearing housing (exclude notch)
$oh = 0.5;  // overhang
$bh = 9.0; // 'butt height' plus some clearance
$tt = 1.0;  // tab thickness


module tab(rr)
{
  color("red")
    rotate(a=[0,0,rr])
      union()
      {
        linear_extrude(height=2) // horiz
          translate([$br + $sw - 1,-$th/2,0])
            square([$mr+$oh+$th/2-$br-$sw + 1,$th]);

        translate([$mr+$oh+$th/2,-$th/2,0]) // vert
          rotate(a=[0,-90,0])
            linear_extrude(height=$tt)
              square([$bh + $sw + $tt/2,$th]);

        translate([$mr+$oh+$th/2,-$th/2,$sw+$bh])
          rotate(a=[-90,-90,0])
            linear_extrude(height=$th)
              polygon([[0,-$tt*2-$oh],[0,0],[$tt*2,0]]);
      }
}

color("black")
  linear_extrude(height=2)
    difference()
    {
      circle($br + $sw);
      circle($br);
    }

  tab(0);
  tab(180);
  
  
  
  
  
  
  
  
  
  