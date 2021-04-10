# 3DObjects
3D CAD objects and related things for public consumption

For now, this source tree contains 'OpenSCAD' files for things that
I have done that I might deem 'convenient' for others to use, at least
as examples for how to use OpenSCAD for 3D Printing.

Some of these files use a 'shrink factor' of 1.02 which is based on the
measured behavior of my particular printer using PLA.  Your Mileage May Vary.

Some of these are simple gears, demonstrating the ability to create useful
mechanical parts with a 3D printer.  The shaft size is actually intended to
be 2mm and not 0.1 inches (it works with my printer).  You can purchase 2mm
metal shafts and small motors with this diameter shaft in various places.
If you want the gear to free-spin, increase the hole size by 25 percent or
so, so that it free-spins but doesn't wobble.

The motor holder is for a particular small motor.  You could include this
in your own design to mount a motor.  YMMV on size, etc..

There is one drawing called 'eductor' that is intended to draw a vacuum by
use of pressurized air, or maybe even steam.  It should get you a pressure
ratio of about 3:1 (throat to manifold pressure, absolute).  You could have
multiple stages to get better ratios, but additional stages would need higher
"moving fluid" flow (i.e. larger nozzle diameter and throat diameter).  This
is about the largest I could print on my printer, so if I staged them, I'd
need to make a smaller one for the first stage.  Or, you could make it in
sections (bolt the horn together at the narrowest point, for example).


One of them is of very practical use, a water bottle cap, for multi-gallon
water jugs.  The caps on those things go bad for some reason, but the bottles
themselves are perfectly fine.  Now you can replace the caps with a 3d printed
version, if you want.  YMMV again, due to shrinkage, etc..


For more information on OpenSCAD:

<a href="http://www.openscad.org/">http://www.openscad.org/</a>

For additional help with 3D Printing, I found these links useful:

<a href="https://www.matterhackers.com/articles/how-to-succeed-when-printing-in-pla">
https://www.matterhackers.com/articles/how-to-succeed-when-printing-in-pla</a><br>
&nbsp;&nbsp;&nbsp;&nbsp;and<br>
<a href="https://www.matterhackers.com/articles/how-to-succeed-when-printing-with-abs">
https://www.matterhackers.com/articles/how-to-succeed-when-printing-with-abs</a><br>


