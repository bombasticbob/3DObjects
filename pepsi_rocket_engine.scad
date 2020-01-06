// pepsi rocket engine
//
// Copyright 2019 by Bob Frazier and S.F.T. Inc.
//
// This program creates a pepsi-bottle 'water rocket' engine that
// mates up with the average soda bottle [not necessarily pepsi].
//
// It provides an 'n diameter hole and parabolic deflector that
// is suited to an atmospheric change of 8:1; that is, a 90psi
// water stream through 'n' diameter should expand to an area
// that is 8 times as large using pi * r^2 such that the flow
// energy will match.  The delta pressure should then
// propel the rocket with an impulse at least 75psi times the
// area of the hole, or 75 * n * n * pi (lbf) where 'n' is the radius.
//
// (this calculation is actually a ballpark; actual value will be different)
//
// For a hole with diameter 1/2" that would be at least 15 lbf.  This allows
// for an upward acceleration of ~2G with ~1 gallon of water.
//
// For a hole with diameter 1/4" that would be 7.5lbf.  This allows for
// an upward acceleration of ~2G with ~1/2 gallon (2L) of water.  With only
// 1L of water, this is closer to 4G [see actual measurements, below].
//
// So the ideal diameter would be about 1/8" to 1/4".  The 1/8" hole would give
// you a longer 'burn', but the 1/4" hole would give you better initial acceleration.
// Between those two values should give you ideal flight characteristics.
//
// The nozzle size will be based on the differential pressure and tendency of turbulent
// water flow to expand.  With an 6:1 pressure expansion (15psi vs 90 psi) this should
// ideally be a ratio of 6; however, the design will use 8 [this way friction against
// the engine walls will be less of a factor, and the shielding effect against the
// surrounding air will still work to provide good thrust shape].
//
// with a diameter of 1/4", the radius is 1/8".  Therefore (with a pressure ratio of 6):
//   0.125 * 0.125 * pi * 6 = pi * 'n' * 'n' ('n' is the final nozzle exit diameter)
//
// So the final exit diameter would ideally be 0.306 * 2 or ~0.6"
// for the design, I'll use 0.6"
//
// Ideally the nozzle exit would be ~4 times the focus distance to get a nice smooth
// engine flow and reasonable shape, since the water will be close to vaporizing with
// turbulent flow. This is really a ballpark guess based on estimated shape of the
// engine nozzle, however.  But it looks cool with this value.
//
// In actual practice, the stream never really hits the parabolic walls. This might
// change if I make the neck shorter, or use a different exit diameter with a ratio of
// 6 instead of 8.  However, I'm leaving it.  It looks cool.
//
// The parabola radius 'x' is proportional to sqrt(y) where 'y=1' is at the focus, and
// 'y=0' is the base of the parabola (where the hole is).
//
// So with focus at 'a', and a parabola height of 4a, the radius is sqrt(4)a.  If the final
// diameter is 3/4", then the value of 'a' is 3/8" and total height is also 3/4"
//
// Above the engine should be a mating collar, and at the bottom, some kind of legs for the
// thing to stand on, which should double as fins to help keep the rocket stable.  Ideally
// they'll spin the bottle along the axis which aids in stability.  I've made this happen by
// doing some 'angling' with the 'scale' parameter in linear_extrude().
//
//
// A mating launcher would need the ability to pressurize the rocket and hang onto the bottom
// until launch, the release it rapidly.  A mechanical design for that will be in a separate
// file. It should grab the collar above the engine, and use one or two clamping pieces, with
// a rod at the bottom side that pulls out to allow launch.  The base should have the ability
// to be screwed down into wood or metal, or be staked it into the ground, for safety.
//
// The basic design requires filling the bottle about half-way with water, attaching the engine
// (with a replaceable paper gasget), quickly invert it onto the launcher, clamp it down and
// lock [with a string attached to the rod].  Then pressurize using a bicycle pump, air
// compressor, or portable air tank.
//
// TODO:  for safety, what is the 'explosion' pressure?  hydro-test with up to 300psi, with
//        printed part, using air alone.
//
// NOTE:  Also for safety purposes, it's possible to fly the rocket with pressures as low as
//        45psi for 2G of initial acceleration with 1L of water.
//
// Ideal flight characteristics might use 1.5L of water for ~2.5G of initial acceleration,
// with pressure at 90psi.
//
//
// Soda bottle 'screw cap' design
// ------------------------------
//
// The pepsi bottle 'screw cap' diameter is 1.12" on the threads, with a thread thickness
// [semi-circular thread shape] of around 1/32", and a pitch of 1/8".  The cap is designed
// to fit this form factor without difficulty attaching it tightly.
//
// NOTE:  make sure fins are not damaged by over-torquing the cap and attempting to remove
//        it again by bracing against the fins for increased torque.
//
// NOTE 2:  1/32" threads are too thin; the cap was blown off at ~100psi.
//
//
// ACTUAL MEASUREMENTS
// ------ ------------
//
// flow rate is approximately 1 liter in 2.5 to 3 seconds, pressurized to ~90psi.
// This gives a mass flow rate of around 350g/sec [initially], with an estimated
// velocity (through a 1/4" hole, 0.317 cm^2) 350cc/sec / 0.317cm = 1105cm/sec
//
// calculating the impulse (mv)
// 1105cm/sec * 350g --> 11.05m/sec * 0.350kg = 3.9N --> 3.9G accel for 1kg (1L) water
//
// This is close to the 4G estimate from earlier.  It means it's working.
//


// BEGIN SCAD PROGRAM

function scaler(n) = n * 0.254 * 1.02;
  // convert 1/100 inch to millimeters
  // with 1.02 shrink factor
function anti_scaler(n) = (n / 0.254) / 1.02;

$fr=4;              // focus ratio ('n'th of total parabola height)
$hr=scaler(12.5);   // 1/8 of an inch in 'hundredths of an inch'
$pw=scaler(30);     // 0.3 inch radius at the bottom
$ph=$pw*sqrt($fr);  // total parabola height ($pw / sqrt($fr)) * $fr;
$fh=$ph/$fr;        // focus height

$to=scaler(112)/2;   // 1.12" outer diameter on threaded part
$ww=scaler(100/16);  // wall width, 1/16"
$ch=scaler(45);      // 0.45" bottle cap height
$bh=scaler(10);      // band 'collar' height 0.1"
$tp=scaler(12.5);    // thread pitch 0.125"
$tr=scaler(5);       // thread radius, 1/20"
$tb=scaler(36);      // thread start (offset from bottom)

// TODO:  shorter collar, 'golf ball' divets within the neck ?

$dy=0.1; // delta Y for loops

// accuracy parameters
$fn=48; // number of faces in shape

translate([0,0,$ch+$ph+scaler(10)+$ww-1])
 rotate(a=[180,0,0])
  difference()
  {
    union()
    {
      color("red")
        for(i0=[$dy:$dy:$fr])
        {
          translate([0,0,$ph-i0*$fh])
            linear_extrude(height=$dy*$fh*1.1)
              circle(sqrt(i0)*$fh+$ww,center=true);
        }

        // top of nozzle, top at $ph + scaler(10)
      color("green")
        translate([0,0,2*$ph/3])
          linear_extrude(height=$ph/3+$bh)
            circle($hr+$ww, center=true);

      color("yellow")
        translate([0,0,$ph+$bh-1]) // position of bottle cap
          linear_extrude(height=$ww+1)
            circle($to+$ww, center=true);

      color("yellow")
        difference()
        {
          translate([0,0,$ph+$bh+$ww-1]) // position of bottle cap
            linear_extrude(height=$ch)
              circle($to+$ww, center=true);

          translate([0,0,$ph+$bh+$ww-1]) // position of bottle cap
            linear_extrude(height=$ch+2)
              circle($to, center=true);
        };

      // threads on bottle cap - a bit hackish but it works

      color("orange")
           for(i3=[3:3:717])
           {
             translate([cos(i3)*$to,sin(i3)*$to,$ph+$bh+$ww+$ch-1 - $tb + $tp*i3/360]) //$ph+scaler(10)+$ww+$ch])
              rotate(a=[90,-90,i3])
                linear_extrude(height=$ww/2, center=true)
                  circle(r=$tr, center=true);
           }

      // fins
      color("purple")
        rotate(a=[0,-90,90])
          translate([0,0,-$ww])
            linear_extrude(height=2*$ww, scale=1.13)
              polygon(points=[[$ph+scaler(10)+$ww-1,$to],[$ph+$bh+$ww-1+$ch/2,$to - scaler(2)],[-$ww,$to*2.5+$ww],[-$ww,$to*2.5]]);

      color("purple")
        rotate(a=[120,-90,90])
          translate([0,0,-$ww])
            linear_extrude(height=2*$ww, scale=1.13)
              polygon(points=[[$ph+scaler(10)+$ww-1,$to],[$ph+$bh+$ww-1+$ch/2,$to - scaler(2)],[-$ww,$to*2.5+$ww],[-$ww,$to*2.5]]);

      color("purple")
        rotate(a=[-120,-90,90])
          translate([0,0,-$ww])
            linear_extrude(height=2*$ww, scale=1.13)
              polygon(points=[[$ph+scaler(10)+$ww-1,$to],[$ph+$bh+$ww-1+$ch/2,$to - scaler(2)],[-$ww,$to*2.5+$ww],[-$ww,$to*2.5]]);

    };

    /*union()
    {
      color("orange")
        for(i2=[$dy:$dy:$fr+2 * $dy])
        {
          translate([0,0,$ph-i2*$fh])
            linear_extrude(height=$dy*$fh*1.1)
              circle(sqrt(i2)*$fh,center=true);
        }

      color("orange")
        translate([0,0,-1])
          linear_extrude(height=$po+scaler(20))
            circle($hr, center=true);
    };*/
  };

