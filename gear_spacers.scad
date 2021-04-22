// gear spacers

$sd = 1.01 * 2.54 * 1.02 / 2; // loose shaft radius

$whd=2.5 * 2.54 * 1.02 / 2; // 0.25" outer diameter

$fn=32;

color("blue")
  union()
  {
    translate([-15,0,0])
      difference()
      {
        linear_extrude(height=2)
          circle($whd);

        translate([0,0,-1])
          linear_extrude(height=6)
            circle($sd);
      }

    translate([-5,0,0])
      difference()
      {
        linear_extrude(height=3)
          circle($whd);

        translate([0,0,-1])
          linear_extrude(height=6)
            circle($sd);
      }

    translate([5,0,0])
      difference()
      {
        linear_extrude(height=3)
          circle($whd);

        translate([0,0,-1])
          linear_extrude(height=6)
            circle($sd);
      }

    translate([15,0,0])
      difference()
      {
        linear_extrude(height=4)
          circle($whd);

        translate([0,0,-1])
          linear_extrude(height=6)
            circle($sd);
      }
  }
      