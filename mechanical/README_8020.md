# A Word to the Wise

As far as manufacturers of structural parts go, 8020 does
an outstanding job of making good documentation available.
It would violate the license agreement on their site for me
to include any of their STL or DXF formatted CAD parts.
It used to be the case that all you needed to do to download
the models was to have an account on their site (which you'd need to
order from them anyway) but now they have partnered with a 3rd
party for this and you have to agree to receive the 3rd party's
spam if you want to download models.

Nearly every part in their catalog in a variety of formats (including
STL and 2D profiles of the extrusions in DXF format) *However*
since they switched over to partnering with PartSolutions the DXF
files they export, while Inkscape (and AutoCad) will import them
they contain some DXF spline primitives which OpenSCAD seems to choke
on.

The way, then, to import the CAD models for 8020 extrusion
profiles into OpenSCAD is to do the following:

1. Sign up for the neccessary account(s).
2. Select the profile you want to model with (e.g.
https://8020.net/40-8080.html) and enter some short-but-valid length (e.g. 100mm).
3. Select the "CAD Files" tab towards the bottom of the product page.
4. Select 3D output in STL format.
5. Download the resulting ZIP archive and extract the STL file.
6. Extract the archive to get at the .STL file.
7. Use the 8020_stl_to_dxf.sh script to export:
+
```bash
 # Straight up export.
 ./8020_stl_to_dxf.sh 40-4080-4000-CL.dxf
 # Translate before projection:
 STL_XFORM='translate([0,40])' ./8020_stl_to_dxf.sh 40-4080-4000-CL.dxf
```
8. Make wrappers for the resulting profiles:
+
```OpenSCAD
 module beam_40_4080(L=500, center=false)
 {
    xlate = [0,0,center ? (-L/2) : 0];
    translate(xlate) linear_extrude(height=L) import("./40-4080-4000-CL.dxf");
 }
```


This makes it relatively easy to pull down the extrusion profiles
you need for your project (rather than using the clunky PartSolutions
widget on 8020's site to generate separate ZIP archives containing an STL file
for each length of each extrusion profile your project contains.

For connectors and fasteners (like these https://8020.net/14104.html)
the STL files you can download from 8020's website can be imported as is
(I've found, sometimes, that it's worth making wrapper modules in OpenSCAD
to normalize the rotation and origin of the imported model to whatever
convention your project is using since since the origin and rotatione are
not always consistent even among CAD models of similar fasteners/connectors
within 8020's inventory and of course they may not be consistent with your
project's conventions.

For example, I tend to make the wrapper modules like the one above for
taking a DXF file and extruding it into a beam of specified length such
that they're analogous to the basic use of OpenSCAD's `cylinder()` primitive
so that:

* The first parameter specifies the height/length of the beam.
* The profile is centered in both X and Y.
* If `center=true` is supplied, it is also centered in the Z axis.

This way it's easy to rotate it to make horizontal-in-X, horizontal-in-Y,
vertical, and arbitrarily rotated beams.  The trade-off is that if you're
modeling beams that stack or abut you'll have to be careful translating them
to avoid fencepost errors.
