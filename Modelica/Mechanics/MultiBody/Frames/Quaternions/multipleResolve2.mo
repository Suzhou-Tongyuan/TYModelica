﻿within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function multipleResolve2 
  "Transform several vectors from frame 1 to frame 2"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "Quaternions orientation object to rotate frame 1 into frame 2";
  input Real v1[3, :] "Vectors in frame 1";
  output Real v2[3, size(v1, 2)] "Vectors in frame 2";
algorithm
  v2 := ((2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) - 
    Q[4]*skew(Q[1:3])))*v1;
  annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
v2 = Quaternions.<strong>multipleResolve2</strong>(Q, v1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function returns vectors&nbsp;v resolved in frame&nbsp;2 (=v2) from vectors&nbsp;v
resolved in frame&nbsp;1 (=v1) using the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q
that describes the orientation to rotate frame&nbsp;1 into frame&nbsp;2.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.multipleResolve2\">TransformationMatrices.multipleResolve2</a>.
</p>
</html>"));
end multipleResolve2;