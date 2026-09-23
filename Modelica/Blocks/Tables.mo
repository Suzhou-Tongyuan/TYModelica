within Modelica.Blocks;
package Tables
  "Library of blocks to interpolate in one and two-dimensional tables"
  extends Modelica.Icons.Package;
  block CombiTable1Ds
    "Table look-up in one dimension (matrix/file) with one input and n outputs"
    extends Modelica.Blocks.Interfaces.SIMO(final nout = size(columns, 1));
    parameter Boolean tableOnFile = false
      "= true, if table is defined on file or in function usertab" 
      annotation(Dialog(group = "Table data definition"));
    parameter Real table[:,:] = fill(0.0, 0, 2)
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(group = "Table data definition", enable = not tableOnFile));
    parameter String tableName = "NoName"
      "Table name on file or in function usertab (see docu)" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter String fileName = "NoName" "File where matrix is stored" 
      annotation(Dialog(
      group = "Table data definition",
      enable = tableOnFile,
      loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)",
      caption = "Open file in which table is present")));
    parameter Boolean verboseRead = true
      "= true, if info message that file is loading is to be printed" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter Integer columns[:] = 2:size(table, 2)
      "Columns of table to be interpolated" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints
      "Extrapolation of data outside the definition range" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Boolean verboseExtrapolation = false
      "= true, if warning messages are to be printed if table input is outside the definition range" 
      annotation(Dialog(group = "Table data interpretation", enable = extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min = Internal.getTable1DAbscissaUmin(tableID)
      "Minimum abscissa value defined in table";
    final parameter Real u_max = Internal.getTable1DAbscissaUmax(tableID)
      "Maximum abscissa value defined in table";
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID =
      Modelica.Blocks.Types.ExternalCombiTable1D(
      if tableOnFile then tableName else "NoName",
      if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
      table,
      columns,
      smoothness,
      extrapolation,
      if tableOnFile then verboseRead else false) "External table object";
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(u >= u_min), "
Extrapolation warning: The value u (="     + String(u) + ") must be greater or equal
than the minimum abscissa value u_min (="     + String(u_min) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u <= u_max), "
Extrapolation warning: The value u (="     + String(u) + ") must be less or equal
than the maximum abscissa value u_max (="     + String(u_max) + ") defined in the table.
"    , level = AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u);
      end for;
    else
      for i in 1:nout loop
        y[i] = Internal.getTable1DValue(tableID, i, u);
      end for;
    end if;
    annotation(
      Documentation(info = "<html>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)
0,0
1,1
2,4
3,9
4,16
double tab2(5,2)
0,0
2,2
4,8
6,18
8,32
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable1Ds.png\"
     alt=\"CombiTable1Ds.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"    ),
      Icon(
      coordinateSystem(preserveAspectRatio = true,
      extent = {{-100.0, -100.0}, {100.0, 100.0}}),
      graphics = {
      Line(points = {{-60.0, 40.0}, {-60.0, -40.0}, {60.0, -40.0}, {60.0, 40.0}, {30.0, 40.0}, {30.0, -40.0}, {-30.0, -40.0}, {-30.0, 40.0}, {-60.0, 40.0}, {-60.0, 20.0}, {60.0, 20.0}, {60.0, 0.0}, {-60.0, 0.0}, {-60.0, -20.0}, {60.0, -20.0}, {60.0, -40.0}, {-60.0, -40.0}, {-60.0, 40.0}, {60.0, 40.0}, {60.0, -40.0}}),
      Line(points = {{0.0, 40.0}, {0.0, -40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 20.0}, {-30.0, 40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 0.0}, {-30.0, 20.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -20.0}, {-30.0, 0.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -40.0}, {-30.0, -20.0}})}));
  end CombiTable1Ds;

  block CombiTable1Dv
    "Table look-up in one dimension (matrix/file) with n inputs and n outputs"
    extends Modelica.Blocks.Interfaces.MIMOs(final n = size(columns, 1));
    parameter Boolean tableOnFile = false
      "= true, if table is defined on file or in function usertab" 
      annotation(Dialog(group = "Table data definition"));
    parameter Real table[:,:] = fill(0.0, 0, 2)
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(group = "Table data definition", enable = not tableOnFile));
    parameter String tableName = "NoName"
      "Table name on file or in function usertab (see docu)" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter String fileName = "NoName" "File where matrix is stored" 
      annotation(Dialog(
      group = "Table data definition",
      enable = tableOnFile,
      loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)",
      caption = "Open file in which table is present")));
    parameter Boolean verboseRead = true
      "= true, if info message that file is loading is to be printed" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter Integer columns[:] = 2:size(table, 2)
      "Columns of table to be interpolated" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints
      "Extrapolation of data outside the definition range" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Boolean verboseExtrapolation = false
      "= true, if warning messages are to be printed if table input is outside the definition range" 
      annotation(Dialog(group = "Table data interpretation", enable = extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min = Internal.getTable1DAbscissaUmin(tableID)
      "Minimum abscissa value defined in table";
    final parameter Real u_max = Internal.getTable1DAbscissaUmax(tableID)
      "Maximum abscissa value defined in table";
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID =
      Modelica.Blocks.Types.ExternalCombiTable1D(
      if tableOnFile then tableName else "NoName",
      if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
      table,
      columns,
      smoothness,
      extrapolation,
      if tableOnFile then verboseRead else false) "External table object";
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      for i in 1:n loop
        assert(noEvent(u[i] >= u_min), "
Extrapolation warning: The value u["     + String(i) + "] (=" + String(u[i]) + ") must be greater or equal
than the minimum abscissa value u_min (="     + String(u_min) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u[i] <= u_max), "
Extrapolation warning: The value u["     + String(i) + "] (=" + String(u[i]) + ") must be less or equal
than the maximum abscissa value u_max (="     + String(u_max) + ") defined in the table.
"    , level = AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u[i]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u[i]);
      end for;
    else
      for i in 1:n loop
        y[i] = Internal.getTable1DValue(tableID, i, u[i]);
      end for;
    end if;
    annotation(
      Documentation(info = "<html>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that 2 input
and 2 output signals are present and that the first output interpolates
the first input via column 2 and the second output interpolates the
second input via column 4 of the table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)
0,0
1,1
2,4
3,9
4,16
double tab2(5,2)
0,0
2,2
4,8
6,18
8,32
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable1Dv.png\"
     alt=\"CombiTable1Dv.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"    ),
      Icon(
      coordinateSystem(preserveAspectRatio = true,
      extent = {{-100.0, -100.0}, {100.0, 100.0}}),
      graphics = {
      Line(points = {{-60.0, 40.0}, {-60.0, -40.0}, {60.0, -40.0}, {60.0, 40.0}, {30.0, 40.0}, {30.0, -40.0}, {-30.0, -40.0}, {-30.0, 40.0}, {-60.0, 40.0}, {-60.0, 20.0}, {60.0, 20.0}, {60.0, 0.0}, {-60.0, 0.0}, {-60.0, -20.0}, {60.0, -20.0}, {60.0, -40.0}, {-60.0, -40.0}, {-60.0, 40.0}, {60.0, 40.0}, {60.0, -40.0}}),
      Line(points = {{0.0, 40.0}, {0.0, -40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 20.0}, {-30.0, 40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 0.0}, {-30.0, 20.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -20.0}, {-30.0, 0.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -40.0}, {-30.0, -20.0}})}));
  end CombiTable1Dv;

  block CombiTable2Ds "Table look-up in two dimensions (matrix/file)"
    extends Modelica.Blocks.Interfaces.SI2SO;
    extends Internal.CombiTable2DBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(u1 >= u_min[1]), "
Extrapolation warning: The value u1 (="     + String(u1) + ") must be greater or equal
than the minimum abscissa value u_min[1] (="     + String(u_min[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u1 <= u_max[1]), "
Extrapolation warning: The value u1 (="     + String(u1) + ") must be less or equal
than the maximum abscissa value u_max[1] (="     + String(u_max[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u2 >= u_min[2]), "
Extrapolation warning: The value u2 (="     + String(u2) + ") must be greater or equal
than the minimum abscissa value u_min[2] (="     + String(u_min[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u2 <= u_max[2]), "
Extrapolation warning: The value u2 (="     + String(u2) + ") must be less or equal
than the maximum abscissa value u_max[2] (="     + String(u_max[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      y = Internal.getTable2DValueNoDer(tableID, u1, u2);
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      y = Internal.getTable2DValueNoDer2(tableID, u1, u2);
    else
      y = Internal.getTable2DValue(tableID, u1, u2);
    end if;
    annotation(
      Documentation(info = "<html>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is 1.0, input u2 is 1.0 and smoothness is LinearSegments, the output y is 1.0,
    e.g., the input u1 is 2.0, input u2 is 1.5 and smoothness is LinearSegments, the output y is 3.0.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0

double table2D_2(4,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0
3.0,3.0,5.0,7.0
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable2Ds.png\"
     alt=\"CombiTable2Ds.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"    ));
  end CombiTable2Ds;

  block CombiTable2Dv "Table look-up in two dimensions (matrix/file) with vector inputs and vector output of size n"
    extends Modelica.Blocks.Interfaces.MI2MO;
    extends Internal.CombiTable2DBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      for j in 1:n loop
        assert(noEvent(u1[j] >= u_min[1]), "
Extrapolation warning: The value u1["     + String(j) + "] (=" + String(u1[j]) + ") must be greater or equal
than the minimum abscissa value u_min[1] (="     + String(u_min[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u1[j] <= u_max[1]), "
Extrapolation warning: The value u1["     + String(j) + "] (=" + String(u1[j]) + ") must be less or equal
than the maximum abscissa value u_max[1] (="     + String(u_max[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u2[j] >= u_min[2]), "
Extrapolation warning: The value u2["     + String(j) + "] (=" + String(u2[j]) + ") must be greater or equal
than the minimum abscissa value u_min[2] (="     + String(u_min[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u2[j] <= u_max[2]), "
Extrapolation warning: The value u2["     + String(j) + "] (=" + String(u2[j]) + ") must be less or equal
than the maximum abscissa value u_max[2] (="     + String(u_max[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer(tableID, u1[j], u2[j]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer2(tableID, u1[j], u2[j]);
      end for;
    else
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValue(tableID, u1[j], u2[j]);
      end for;
    end if;
    annotation(Documentation(info = "<html>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is {1.0}, input u2 is {1.0} and smoothness is LinearSegments, the output y is {1.0},
    e.g., the input u1 is {2.0}, input u2 is {1.5} and smoothness is LinearSegments, the output y is {3.0}.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0

double table2D_2(4,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0
3.0,3.0,5.0,7.0
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable2Dv.png\"
     alt=\"CombiTable2Dv.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"    ));
  end CombiTable2Dv;
  block CombiTable1DTs
    "Parameter tunable. Table look-up in one dimension (matrix/file) with one input and n outputs"
    extends Modelica.Blocks.Interfaces.SIMO(final nout = size(columns, 1));
    parameter Boolean tableOnFile = false
      "= true, if table is defined on file or in function usertab" 
      annotation(Dialog(group = "Table data definition"));
    parameter Real table[:,:] = fill(0.0, 0, 2)
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(group = "Table data definition", enable = not tableOnFile));
    parameter String tableName = "NoName"
      "Table name on file or in function usertab (see docu)" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter String fileName = "NoName" "File where matrix is stored" 
      annotation(Dialog(
      group = "Table data definition",
      enable = tableOnFile,
      loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)",
      caption = "Open file in which table is present")));
    parameter Boolean verboseRead = true
      "= true, if info message that file is loading is to be printed" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter Integer columns[:] = 2:size(table, 2)
      "Columns of table to be interpolated" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints
      "Extrapolation of data outside the definition range" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Boolean verboseExtrapolation = false
      "= true, if warning messages are to be printed if table input is outside the definition range" 
      annotation(Dialog(group = "Table data interpretation", enable = extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min(fixed = false)
      "Minimum abscissa value defined in table";
    final parameter Real u_max(fixed = false)
      "Maximum abscissa value defined in table";
    final parameter Real tableT[:,:] = fill(0.0, 0, 2);
    final parameter Integer columnsT[:] = 2:size(tableT, 2);
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID =
      Modelica.Blocks.Types.ExternalCombiTable1D(
      "tunable",
      "tunable",
      tableT,
      columnsT,
      0,
      0,
      false) "External table object";
  initial algorithm
    Internal.initCombiTable1DT(if tableOnFile then tableName else "NoName",
      if tableOnFile and loadResource(fileName) <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then loadResource(fileName) else "NoName",
      table,
      columns,
      smoothness,
      extrapolation,
      if tableOnFile then verboseRead else false,
      tableID) "External table object";
    u_min := Internal.getTable1DAbscissaUmin(tableID);
    u_max := Internal.getTable1DAbscissaUmax(tableID);
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(u >= u_min), "
Extrapolation warning: The value u (="                                                         + String(u) + ") must be greater or equal
than the minimum abscissa value u_min (="                                                         + String(u_min) + ") defined in the table.
"                                                        , level = AssertionLevel.warning);
      assert(noEvent(u <= u_max), "
Extrapolation warning: The value u (="                                                         + String(u) + ") must be less or equal
than the maximum abscissa value u_max (="                                                         + String(u_max) + ") defined in the table.
"                                                        , level = AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u);
      end for;
    else
      for i in 1:nout loop
        y[i] = Internal.getTable1DValue(tableID, i, u);
      end for;
    end if;
    annotation(
      Documentation(info = "<html>
<p>
Parameters of the FMU exported from this table are tunable.  
This feature can only be used when parameter estimation is not enabled.
</p>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)
0,0
1,1
2,4
3,9
4,16
double tab2(5,2)
0,0
2,2
4,8
6,18
8,32
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable1Ds.png\"
     alt=\"CombiTable1Ds.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"                                                        ),
      Icon(
      coordinateSystem(preserveAspectRatio = true,
      extent = {{-100.0, -100.0}, {100.0, 100.0}}),
      graphics = {
      Line(points = {{-60.0, 40.0}, {-60.0, -40.0}, {60.0, -40.0}, {60.0, 40.0}, {30.0, 40.0}, {30.0, -40.0}, {-30.0, -40.0}, {-30.0, 40.0}, {-60.0, 40.0}, {-60.0, 20.0}, {60.0, 20.0}, {60.0, 0.0}, {-60.0, 0.0}, {-60.0, -20.0}, {60.0, -20.0}, {60.0, -40.0}, {-60.0, -40.0}, {-60.0, 40.0}, {60.0, 40.0}, {60.0, -40.0}}),
      Line(points = {{0.0, 40.0}, {0.0, -40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 20.0}, {-30.0, 40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 0.0}, {-30.0, 20.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -20.0}, {-30.0, 0.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -40.0}, {-30.0, -20.0}})}),experiment(Algorithm=Dassl,InlineIntegrator=false,InlineStepSize=false,NumberOfIntervals=500,StartTime=0,StopTime=1,StoreEventValue=0,Tolerance=0.0001),__MWORKS(ContinueSimConfig(SaveContinueFile="false",SaveBeforeStop="false",NumberBeforeStop=1,FixedContinueInterval="false",ContinueIntervalLength=0.334,ContinueTimeVector)));
  end CombiTable1DTs;
  block CombiTable1DTv
    "Parameter tunable. Table look-up in one dimension (matrix/file) with n inputs and n outputs"
    extends Modelica.Blocks.Interfaces.MIMOs(final n = size(columns, 1));
    parameter Boolean tableOnFile = false
      "= true, if table is defined on file or in function usertab" 
      annotation(Dialog(group = "Table data definition"));
    parameter Real table[:,:] = fill(0.0, 0, 2)
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(group = "Table data definition", enable = not tableOnFile));
    parameter String tableName = "NoName"
      "Table name on file or in function usertab (see docu)" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter String fileName = "NoName" "File where matrix is stored" 
      annotation(Dialog(
      group = "Table data definition",
      enable = tableOnFile,
      loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)",
      caption = "Open file in which table is present")));
    parameter Boolean verboseRead = true
      "= true, if info message that file is loading is to be printed" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter Integer columns[:] = 2:size(table, 2)
      "Columns of table to be interpolated" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints
      "Extrapolation of data outside the definition range" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Boolean verboseExtrapolation = false
      "= true, if warning messages are to be printed if table input is outside the definition range" 
      annotation(Dialog(group = "Table data interpretation", enable = extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min(fixed = false)
      "Minimum abscissa value defined in table";
    final parameter Real u_max(fixed = false)
      "Maximum abscissa value defined in table";
    final parameter Real tableT[:,:] = fill(0.0, 0, 2);
    final parameter Integer columnsT[:] = 2:size(tableT, 2);
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID =
      Modelica.Blocks.Types.ExternalCombiTable1D(
      "tunable",
      "tunable",
      tableT,
      columnsT,
      0,
      0,
      false) "External table object";
  initial algorithm
    Internal.initCombiTable1DT(if tableOnFile then tableName else "NoName",
      if tableOnFile and loadResource(fileName) <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then loadResource(fileName) else "NoName",
      table,
      columns,
      smoothness,
      extrapolation,
      if tableOnFile then verboseRead else false,
      tableID) "External table object";
    u_min := Internal.getTable1DAbscissaUmin(tableID);
    u_max := Internal.getTable1DAbscissaUmax(tableID);
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      for i in 1:n loop
        assert(noEvent(u[i] >= u_min), "
Extrapolation warning: The value u["                                 + String(i) + "] (=" + String(u[i]) + ") must be greater or equal
than the minimum abscissa value u_min (="                                 + String(u_min) + ") defined in the table.
"                                , level = AssertionLevel.warning);
        assert(noEvent(u[i] <= u_max), "
Extrapolation warning: The value u["                                 + String(i) + "] (=" + String(u[i]) + ") must be less or equal
than the maximum abscissa value u_max (="                                 + String(u_max) + ") defined in the table.
"                                , level = AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u[i]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u[i]);
      end for;
    else
      for i in 1:n loop
        y[i] = Internal.getTable1DValue(tableID, i, u[i]);
      end for;
    end if;
    annotation(
      Documentation(info = "<html>
<p>
Parameters of the FMU exported from this table are tunable.  
This feature can only be used when parameter estimation is not enabled.
</p>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that 2 input
and 2 output signals are present and that the first output interpolates
the first input via column 2 and the second output interpolates the
second input via column 4 of the table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)
0,0
1,1
2,4
3,9
4,16
double tab2(5,2)
0,0
2,2
4,8
6,18
8,32
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable1Dv.png\"
     alt=\"CombiTable1Dv.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"                                ),
      Icon(
      coordinateSystem(preserveAspectRatio = true,
      extent = {{-100.0, -100.0}, {100.0, 100.0}}),
      graphics = {
      Line(points = {{-60.0, 40.0}, {-60.0, -40.0}, {60.0, -40.0}, {60.0, 40.0}, {30.0, 40.0}, {30.0, -40.0}, {-30.0, -40.0}, {-30.0, 40.0}, {-60.0, 40.0}, {-60.0, 20.0}, {60.0, 20.0}, {60.0, 0.0}, {-60.0, 0.0}, {-60.0, -20.0}, {60.0, -20.0}, {60.0, -40.0}, {-60.0, -40.0}, {-60.0, 40.0}, {60.0, 40.0}, {60.0, -40.0}}),
      Line(points = {{0.0, 40.0}, {0.0, -40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 20.0}, {-30.0, 40.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, 0.0}, {-30.0, 20.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -20.0}, {-30.0, 0.0}}),
      Rectangle(fillColor = {255, 215, 136},
      fillPattern = FillPattern.Solid,
      extent = {{-60.0, -40.0}, {-30.0, -20.0}})}));
  end CombiTable1DTv;
  block CombiTable2DTs "Parameter tunable. Table look-up in two dimensions (matrix/file)"
    extends Modelica.Blocks.Interfaces.SI2SO;
    extends Internal.CombiTable2DTBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(u1 >= u_min[1]), "
Extrapolation warning: The value u1 (="                       + String(u1) + ") must be greater or equal
than the minimum abscissa value u_min[1] (="                       + String(u_min[1]) + ") defined in the table.
"                      , level = AssertionLevel.warning);
      assert(noEvent(u1 <= u_max[1]), "
Extrapolation warning: The value u1 (="                       + String(u1) + ") must be less or equal
than the maximum abscissa value u_max[1] (="                       + String(u_max[1]) + ") defined in the table.
"                      , level = AssertionLevel.warning);
      assert(noEvent(u2 >= u_min[2]), "
Extrapolation warning: The value u2 (="                       + String(u2) + ") must be greater or equal
than the minimum abscissa value u_min[2] (="                       + String(u_min[2]) + ") defined in the table.
"                      , level = AssertionLevel.warning);
      assert(noEvent(u2 <= u_max[2]), "
Extrapolation warning: The value u2 (="                       + String(u2) + ") must be less or equal
than the maximum abscissa value u_max[2] (="                       + String(u_max[2]) + ") defined in the table.
"                      , level = AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      y = Internal.getTable2DValueNoDer(tableID, u1, u2);
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      y = Internal.getTable2DValueNoDer2(tableID, u1, u2);
    else
      y = Internal.getTable2DValue(tableID, u1, u2);
    end if;
    annotation(
      Documentation(info = "<html>
<p>
Parameters of the FMU exported from this table are tunable.  
This feature can only be used when parameter estimation is not enabled.
</p>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is 1.0, input u2 is 1.0 and smoothness is LinearSegments, the output y is 1.0,
    e.g., the input u1 is 2.0, input u2 is 1.5 and smoothness is LinearSegments, the output y is 3.0.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0

double table2D_2(4,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0
3.0,3.0,5.0,7.0
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable2Ds.png\"
     alt=\"CombiTable2Ds.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"                      ));
  end CombiTable2DTs;
  block CombiTable2DTv "Parameter tunable. Table look-up in two dimensions (matrix/file) with vector inputs and vector output of size n"
    extends Modelica.Blocks.Interfaces.MI2MO;
    extends Internal.CombiTable2DTBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      for j in 1:n loop
        assert(noEvent(u1[j] >= u_min[1]), "
Extrapolation warning: The value u1["                 + String(j) + "] (=" + String(u1[j]) + ") must be greater or equal
than the minimum abscissa value u_min[1] (="                 + String(u_min[1]) + ") defined in the table.
"                , level = AssertionLevel.warning);
        assert(noEvent(u1[j] <= u_max[1]), "
Extrapolation warning: The value u1["                 + String(j) + "] (=" + String(u1[j]) + ") must be less or equal
than the maximum abscissa value u_max[1] (="                 + String(u_max[1]) + ") defined in the table.
"                , level = AssertionLevel.warning);
        assert(noEvent(u2[j] >= u_min[2]), "
Extrapolation warning: The value u2["                 + String(j) + "] (=" + String(u2[j]) + ") must be greater or equal
than the minimum abscissa value u_min[2] (="                 + String(u_min[2]) + ") defined in the table.
"                , level = AssertionLevel.warning);
        assert(noEvent(u2[j] <= u_max[2]), "
Extrapolation warning: The value u2["                 + String(j) + "] (=" + String(u2[j]) + ") must be less or equal
than the maximum abscissa value u_max[2] (="                 + String(u_max[2]) + ") defined in the table.
"                , level = AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer(tableID, u1[j], u2[j]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer2(tableID, u1[j], u2[j]);
      end for;
    else
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValue(tableID, u1[j], u2[j]);
      end for;
    end if;
    annotation(Documentation(info = "<html>
<p>
Parameters of the FMU exported from this table are tunable.  
This feature can only be used when parameter estimation is not enabled.
</p>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is {1.0}, input u2 is {1.0} and smoothness is LinearSegments, the output y is {1.0},
    e.g., the input u1 is {2.0}, input u2 is {1.5} and smoothness is LinearSegments, the output y is {3.0}.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0

double table2D_2(4,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0
3.0,3.0,5.0,7.0
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable2Dv.png\"
     alt=\"CombiTable2Dv.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"                ));
  end CombiTable2DTv;
  package NTables"Library of blocks to interpolate in N-dimensional tables"

    model LookupTable1D "One-dimensional linear interpolation table"
      parameter Tables.Types.InterpolationMethod interpMethod = Tables.Types.InterpolationMethod.Linear
        "Interpolation method";
      parameter Tables.Types.ExtrapolationMethod extrapMethod = Tables.Types.ExtrapolationMethod.Linear
        "Extrapolation method";

      parameter Boolean tableDataOnFile = false "= true, if table is defined on file" 
        annotation(Dialog(group = "Table data Switch"));
      parameter Boolean breakPointsOnFile = false "= true, if breakPoints is defined on file" 
        annotation(Dialog(group = "Table data Switch"));

      parameter Real breakPoints1[:] = {0} "breakpoints 1, specified as a vector with strictly monotonically increasing values." 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real tableData[:] = {0} "tabledata, specifies as an associated set of output values" 
        annotation(Dialog(group = "Table data definition", enable = not tableDataOnFile));
      parameter String filePath = "none" "file path where data is stored" 
        annotation(Dialog(group = "Table data definition", enable = (tableDataOnFile or breakPointsOnFile),
        loadSelector(filter = "Text files (*.csv)", caption = "Open file in which table is present")));
      parameter Integer bp_cols[:] = {-1} "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = breakPointsOnFile));
      parameter Integer tableData_col = -1 "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = tableDataOnFile));

      Modelica.Blocks.Interfaces.RealInput u 
        annotation(Placement(transformation(origin = {-120.116, -0.405796},
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y 
        annotation(Placement(transformation(origin = {110.377, 2.02899e-7},
        extent = {{-10, -10}, {10, 10}})));

    protected
      Integer bp_sizes[:] = {size(breakPoints1, 1)} "columns of the data to be interpolated in the table";
      Tables.Types.External1DTable externalTable = Tables.Types.External1DTable(filePath, tableData_col, bp_cols, breakPoints1, bp_sizes, tableData);

    equation
      y = Tables.Types.evaluate1D(
        externalTable,
        {u},
        interpMethod,
        extrapMethod);

      annotation(Documentation(info = "<html><p>
Performs an n-dimensional interpolation table lookup where n=1. The table is a sampled representation of N variables among the function. The breakpoint sets associates input values with positions in the table.
</p>
<p>
The 1-D Lookup Table, 2-D Lookup Table and n-D Lookup Table compute the n-variable sampling representation of a function:
</p>
<p>
<span data-w-e-type=\"formula\" data-w-e-is-void data-w-e-is-inline data-value=\"y=F(x_1,x_2,x_3,...,x_N)\"></span><br>Where function F is an empirical function.
</p>
<p>
The module maps the input to the output value by finding or inserting a table of values that you defined using the module parameters. The Homogeneous (constant), Linear (linear point-slope), Nearest, Akima spline, Fritsch-Butland spline, &nbsp;Steffen spline interpolation methods and the Homogeneous (constant), Linear (linear point-slope) extrapolation methods are supported.
</p>
<p>
In the following table, the first column identifies breakPoints 1, and the second column identifies the tableData.
</p>
<p>
For example, when the breakPoints1 is {-1,0,1.2},and the corresponding value is {1, 2, 3},you can set the tableData to be {1, 2, 3} directly.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LookupTable1D.png\"
     alt=\"LookupTable1D.png\">
</div>
</html>"                  ), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}},

        grid = {2, 2}), graphics = {Rectangle(origin = {0.215072, -0.86029},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {2, 0},
        lineColor = {47, 49, 172},
        fillColor = {255, 255, 125},
        fillPattern = FillPattern.Solid,
        extent = {{-60, 60}, {60, -60}}), Line(origin = {-18, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}), Line(origin = {22, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}), Line(origin = {6, -21},
        rotation = 90,
        points = {{1, 64}, {1, -56}},
        color = {161, 159, 189}), Line(origin = {18, 19},
        rotation = 90,
        points = {{1, 76}, {1, -44}},
        color = {161, 159, 189}), Text(origin = {3, -132},
        lineColor = {0, 0, 0},
        extent = {{-150, -20}, {150, 20}},
        textString = "%name",
        textColor = {0, 0, 0}), Rectangle(origin = {2, 0},
        lineColor = {47, 49, 172},
        extent = {{-60, 60}, {60, -60}})}));
    end LookupTable1D;
    model LookupTable2D "Two-dimensional linear interpolation table"
      parameter Tables.Types.InterpolationMethod interpMethod = Tables.Types.InterpolationMethod.Linear
        "Interpolation method";
      parameter Tables.Types.ExtrapolationMethod extrapMethod = Tables.Types.ExtrapolationMethod.Linear
        "Extrapolation method";

      parameter Boolean tableDataOnFile = false "= true, if table is defined on file" 
        annotation(Dialog(group = "Table data Switch"));
      parameter Boolean breakPointsOnFile = false "= true, if breakPoints is defined on file" 
        annotation(Dialog(group = "Table data Switch"));

      parameter Real breakPoints1[:] = {0} "breakpoints 1, specified as a vector with strictly monotonically increasing valuess" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));
      parameter Real breakPoints2[:] = {0} "breakpoints 2, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real tableData[:,:] = {{0}} "tabledata, specifies as an 2-D array of elements arranged in main order of columns" 
        annotation(Dialog(group = "Table data definition", enable = not tableDataOnFile));
      parameter String filePath = "none" "file path where data is stored" 
        annotation(Dialog(group = "Table data definition", enable = (tableDataOnFile or breakPointsOnFile),
        loadSelector(filter = "Text files (*.csv)", caption = "Open file in which table is present")));
      parameter Integer bp_cols[:] = {-1, -1} "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = breakPointsOnFile));
      parameter Integer tableData_col = -1 "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = tableDataOnFile));

      Modelica.Blocks.Interfaces.RealInput u1 
        annotation(Placement(transformation(origin = {-121.058, 40.1216},
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealInput u2 
        annotation(Placement(transformation(origin = {-121.582, -39.899},
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y 
        annotation(Placement(transformation(origin = {110.377, 2.02899e-7},
        extent = {{-10, -10}, {10, 10}})));

    protected
      Integer bp_sizes[:] = {size(breakPoints1, 1), size(breakPoints2, 1)} "columns of the data to be interpolated in the table";
      Real tableDataVec[size(breakPoints1, 1) * size(breakPoints2, 1)] = Utilities.arr2D2vec(tableData);
      Tables.Types.External2DTable externalTable = Tables.Types.External2DTable(filePath, tableData_col, bp_cols, breakPoints1, breakPoints2, bp_sizes, tableDataVec);

    equation
      y = Tables.Types.evaluate2D(
        externalTable,
        {u1, u2},
        interpMethod,
        extrapMethod);

      annotation(Documentation(info = "<html><p>
Performs an n-dimensional interpolation table lookup where n=2. The table is a sampled representation of N variables among the function. The breakpoint sets associates input values with positions in the table.
</p>
<p>
The 1-D Lookup Table, 2-D Lookup Table and n-D Lookup Table compute the n-variable sampling representation of a function:
</p>
<p>
<span data-w-e-type=\"formula\" data-w-e-is-void data-w-e-is-inline data-value=\"y=F(x_1,x_2,x_3,...,x_N)\"></span><br>Where function F is an empirical function.
</p>
<p>
The module maps the input to the output value by finding or inserting a table of values that you defined using the module parameters. The Homogeneous (constant), Linear (linear point-slope), Nearest, Akima spline, Fritsch-Butland spline, &nbsp;Steffen spline interpolation methods and the Homogeneous (constant), Linear (linear point-slope) extrapolation methods are supported.
</p>
<p>
In the following table, the first column identifies the breakPoints 1, the first row identifies the breakPoints 2, and the tableData &nbsp;is identified by the others.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LookupTable2D.png\"
     alt=\"LookupTable2D.png\">
</div>
<p>
For example, when the breakPoints1 is {-1,0,1.2}, the breakPoints2 is {-2.3, -1.07, 0.05} and the corresponding value is {1, 2, 3, 4, 5, 6, 7, 8, 9},you can set the tableData {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}. 
</p>
<p>
 For 2D lookup table import, the CSV data must be consistent with the breakpoint definition:
</p>
<ul><li>
breakPoints1 and breakPoints2 define the sampling positions of the two input dimensions.</li>
<li>
Both breakpoint vectors must be strictly monotonically increasing.</li>
<li>
tableData[i,j] corresponds to the point (breakPoints1[i], breakPoints2[j]).</li>
<li>
The size of tableData must satisfy size(tableData,1) = length(breakPoints1) and size(tableData,2) = length(breakPoints2).</li>
<li>
Conceptually, the first column identifies breakPoints1, the first row identifies breakPoints2, and the remaining elements identify the table values.</li>
<li>
In the current CSV implementation, the file may also be stored as a serialized representation of the 2D table, where breakpoint vectors and flattened table values are stored separately.</li>
<li>
Header rows and unsupported empty cells should be avoided in the CSV file.</li>
</ul><ul><li>
The breakpoint ranges should be selected to cover the expected operating range of the inputs in order to reduce extrapolation effects.<br><br><br></li>
</ul></html>"          ), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}},
        grid = {2, 2}), graphics = {Rectangle(origin = {0.215072, -0.86029},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {2, 0},
        lineColor = {47, 49, 172},
        fillColor = {255, 255, 125},
        fillPattern = FillPattern.Solid,
        extent = {{-60, 60}, {60, -60}}), Line(origin = {-18, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}), Line(origin = {22, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}), Line(origin = {6, -21},
        rotation = 90,
        points = {{1, 64}, {1, -56}},
        color = {161, 159, 189}), Line(origin = {18, 19},
        rotation = 90,
        points = {{1, 76}, {1, -44}},
        color = {161, 159, 189}), Text(origin = {3, -132},
        lineColor = {0, 0, 0},
        extent = {{-150, -20}, {150, 20}},
        textString = "%name",
        textColor = {0, 0, 0}), Rectangle(origin = {2, 0},
        lineColor = {47, 49, 172},
        extent = {{-60, 60}, {60, -60}})}), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
        grid = {2, 2})));
    end LookupTable2D;
    model LookupTable3D "Three-dimensional linear interpolation table"
      parameter Tables.Types.InterpolationMethod interpMethod =
        Tables.Types.InterpolationMethod.Linear
        "Interpolation method";

      parameter Tables.Types.ExtrapolationMethod extrapMethod =
        Tables.Types.ExtrapolationMethod.Linear
        "Extrapolation method";

      parameter Boolean tableDataOnFile = false
        "= true, if table is defined on file" 
        annotation(Dialog(group = "Table data Switch"));

      parameter Boolean breakPointsOnFile = false
        "= true, if breakPoints is defined on file" 
        annotation(Dialog(group = "Table data Switch"));

      parameter Real breakPoints1[:] = {0}
        "breakpoints 1, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real breakPoints2[:] = {0}
        "breakpoints 2, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real breakPoints3[:] = {0}
        "breakpoints 3, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real tableData[:,:,:] = {{{0}}}
        "tabledata, specifies as an 3-D array of elements arranged in main order of columns" 
        annotation(Dialog(group = "Table data definition", enable = not tableDataOnFile));

      parameter String filePath = "none"
        "file path where data is stored" 
        annotation(Dialog(
        group = "Table data definition",
        enable = (tableDataOnFile or breakPointsOnFile),
        loadSelector(
        filter = "Text files (*.csv)",
        caption = "Open file in which table is present"
        )
        ));

      parameter Integer bp_cols[:] = {-1, -1, -1}
        "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = breakPointsOnFile));

      parameter Integer tableData_col = -1
        "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = tableDataOnFile));

      Modelica.Blocks.Interfaces.RealInput u1 
        annotation(Placement(transformation(
        origin = {-120.43, 59.914},
        extent = {{-20, -20}, {20, 20}}
        )));

      Modelica.Blocks.Interfaces.RealInput u2 
        annotation(Placement(transformation(
        origin = {-120.325, -0.314147},
        extent = {{-20, -20}, {20, 20}}
        )));

      Modelica.Blocks.Interfaces.RealInput u3 
        annotation(Placement(transformation(
        origin = {-120.325, -59.6914},
        extent = {{-20, -20}, {20, 20}}
        )));

      Modelica.Blocks.Interfaces.RealOutput y 
        annotation(Placement(transformation(
        origin = {110.377, 2.02899e-7},
        extent = {{-10, -10}, {10, 10}}
        )));

    protected
      Real tableDataVec[size(breakPoints1, 1) * size(breakPoints2, 1) * size(breakPoints3, 1)] = Utilities.arr3D2vec(tableData);

      Tables.Types.External3DTable externalTable =
        Tables.Types.External3DTable(
        filePath,
        tableData_col,
        bp_cols,
        breakPoints1,
        breakPoints2,
        breakPoints3,
        {
        size(breakPoints1, 1),
        size(breakPoints2, 1),
        size(breakPoints3, 1)
        },   // bpSizes
        tableDataVec
        );

    equation
      y = Tables.Types.evaluate3D(
        externalTable,
        {u1, u2, u3},
        interpMethod,
        extrapMethod
        );

      annotation(
        Documentation(info = "<html><p>
Performs an n-dimensional interpolation table lookup where n=3. The table is a sampled representation of N variables among the function. The breakpoint sets associates input values with positions in the table.<br>The 1-D Lookup Table, 2-D Lookup Table and n-D Lookup Table compute the n-variable sampling representation of a function:
</p>
<p>
<span data-w-e-type=\"formula\" data-w-e-is-void data-w-e-is-inline data-value=\"y=F(x_1,x_2,x_3,...,x_N)\"></span><br>Where function F is an empirical function.
</p>
<p>
The module maps the input to the output value by finding or inserting a table of values that you defined using the module parameters. The Homogeneous (constant), Linear (linear point-slope), Nearest, Akima spline, Fritsch-Butland spline, &nbsp;Steffen spline interpolation methods and the Homogeneous (constant), Linear (linear point-slope) extrapolation methods are supported.
</p>
<p>
The 3DLookupTable is obtained by superimposing and expanding 2DLookupTable. Each page of the 3DLookupTable is a 2DLookupTable.
</p>
<p>
For example, when the breakPoints1 is {-1,0,1.2}, the breakPoints2 is {-2.3, -1.07, 0.05} and the corresponding value is {1, 2, 3, 4, 5, 6, 7, 8, 9},you can set the tableData {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LookupTable2D.png\"
     alt=\"LookupTable2D.png\">
</div>
<p>
In the following module, the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">breakPoints 1 is </span>identified by <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">the first column of each page of the table</span>, the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"> breakPoints 2 is </span>identifiesd by <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">the first row of each page of the table</span>, and the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">breakPoints 3 is </span>identifiesd by the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">pages of the table, the tableData is identified by the others.</span>
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LookupTable3D.png\"
     alt=\"LookupTable3D.png\">
</div>
<p>
For CSV import, the data in the file must be consistent with the breakpoint definition of the 3D lookup table.
</p>
<ul><li>
breakPoints1, breakPoints2, and breakPoints3 represent the sampling points of the three input dimensions.</li>
<li>
Each breakpoint vector must be strictly monotonically increasing.</li>
<li>
The total number of table values must equal length(breakPoints1) * length(breakPoints2) * length(breakPoints3).</li>
<li>
In the conceptual 3D table, each page corresponds to one value of breakPoints3, the first column of each page corresponds to breakPoints1, and the first row corresponds to breakPoints2.</li>
<li>
In the current CSV implementation, however, the breakpoint sets are stored in separate columns and the table values are stored in one dedicated column as a flattened sequence. Therefore, the CSV file is a serialized representation of the page-based 3D table.</li>
<li>
The order of values in the tableData column must exactly match the internal flattening/storage order used by the block.</li>
<li>
Header rows and unsupported empty cells should be avoided in the CSV file.</li>
<li>
The breakpoint ranges should be chosen to cover the expected operating range of the inputs to reduce unwanted extrapolation effects.</li>
</ul></html>"                  ),
        Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {2, 2}),
        graphics = {
        Rectangle(
        origin = {-1, 1.01449e-7},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-101, 100}, {101, -100}}
        ),
        Rectangle(
        origin = {2, 0},
        lineColor = {47, 49, 172},
        fillColor = {255, 255, 125},
        fillPattern = FillPattern.Solid,
        extent = {{-60, 60}, {60, -60}}
        ),
        Line(
        origin = {-18, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}
        ),
        Line(
        origin = {22, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}
        ),
        Line(
        origin = {6, -21},
        rotation = 90,
        points = {{1, 64}, {1, -56}},
        color = {161, 159, 189}
        ),
        Line(
        origin = {18, 19},
        rotation = 90,
        points = {{1, 76}, {1, -44}},
        color = {161, 159, 189}
        ),
        Text(
        origin = {3, -132},
        lineColor = {0, 0, 0},
        extent = {{-150, -20}, {150, 20}},
        textString = "%name",
        textColor = {0, 0, 0}
        ),
        Rectangle(
        origin = {2, 0},
        lineColor = {47, 49, 172},
        extent = {{-60, 60}, {60, -60}}
        )
        }
        ),
        Diagram(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {2, 2})
        )
        );
    end LookupTable3D;




    model LookupTable4D "Four-dimensional linear interpolation table"
      parameter Tables.Types.InterpolationMethod interpMethod =
        Tables.Types.InterpolationMethod.Linear "Interpolation method";
      parameter Tables.Types.ExtrapolationMethod extrapMethod =
        Tables.Types.ExtrapolationMethod.Linear "Extrapolation method";

      parameter Boolean tableDataOnFile = false "= true, if table is defined on file" 
        annotation(Dialog(group = "Table data Switch"));
      parameter Boolean breakPointsOnFile = false "= true, if breakPoints is defined on file" 
        annotation(Dialog(group = "Table data Switch"));

      parameter Real breakPoints1[:] = {0}
        "breakpoints 1, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));
      parameter Real breakPoints2[:] = {0}
        "breakpoints 2, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));
      parameter Real breakPoints3[:] = {0}
        "breakpoints 3, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));
      parameter Real breakPoints4[:] = {0}
        "breakpoints 4, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real tableData[:,:,:,:] = {{{{0}}}}
        "tabledata, specified as a 4-D array (must match the flattening order used by arr4D2vec)" 
        annotation(Dialog(group = "Table data definition", enable = not tableDataOnFile));

      parameter String filePath = "none" "file path where data is stored" 
        annotation(Dialog(group = "Table data definition",
        enable = (tableDataOnFile or breakPointsOnFile),
        loadSelector(filter = "Text files (*.csv)", caption = "Open file in which table is present")));

      parameter Integer bp_cols[:] = {-1, -1, -1, -1}
        "columns of breakpoints in the file" 
        annotation(Dialog(group = "Table data definition", enable = breakPointsOnFile));

      parameter Integer tableData_col = -1
        "column of the table data in the file" 
        annotation(Dialog(group = "Table data definition", enable = tableDataOnFile));

      Modelica.Blocks.Interfaces.RealInput u1 
        annotation(Placement(transformation(origin = {-121, 60}, extent = {{-20, -20}, {20, 20}})), __MWORKS(ShowPortName = true));
      Modelica.Blocks.Interfaces.RealInput u2 
        annotation(Placement(transformation(origin = {-121, 20}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealInput u3 
        annotation(Placement(transformation(origin = {-121, -20}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealInput u4 
        annotation(Placement(transformation(origin = {-121, -60}, extent = {{-20, -20}, {20, 20}})));

      Modelica.Blocks.Interfaces.RealOutput y 
        annotation(Placement(transformation(origin = {112, 4},
        extent = {{-10, -10}, {10, 10}})), __MWORKS(ShowPortName = true));

    protected
      Integer bp_sizes[:] = {size(breakPoints1, 1), size(breakPoints2, 1), size(breakPoints3, 1), size(breakPoints4, 1)};
      Real tableDataVec[size(breakPoints1, 1) * size(breakPoints2, 1) * size(breakPoints3, 1) * size(breakPoints4, 1)] =
        Utilities.arr4D2vec(tableData);

      Tables.Types.External4DTable externalTable =
        Tables.Types.External4DTable(
        filePath, tableData_col, bp_cols,
        breakPoints1, breakPoints2, breakPoints3, breakPoints4,
        bp_sizes, tableDataVec);

    equation
      y = Tables.Types.evaluate4D(
        externalTable,
        {u1, u2, u3, u4},
        interpMethod,
        extrapMethod);

      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}},
        grid = {2, 2}), graphics = {Rectangle(origin = {1, 2},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-101, 102}, {101, -102}}), Rectangle(origin = {0.5, 0},
        lineColor = {47, 49, 172},
        fillColor = {255, 255, 125},
        fillPattern = FillPattern.Solid,
        extent = {{-60, 60}, {60, -60}}), Line(origin = {-19.5, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}), Line(origin = {20.5, 0},
        points = {{0, 60}, {0, -60}},
        color = {161, 159, 189}), Line(origin = {4.5, -21},
        rotation = 90,
        points = {{1, 64}, {1, -56}},
        color = {161, 159, 189}), Line(origin = {16.5, 19},
        rotation = 90,
        points = {{1, 76}, {1, -44}},
        color = {161, 159, 189}), Rectangle(origin = {0.5, 0},
        lineColor = {47, 49, 172},
        extent = {{-60, 60}, {60, -60}}), Text(origin = {0.5, -128},
        lineColor = {0, 0, 0},
        extent = {{-150, -20}, {150, 20}},
        textString = "%name",
        textColor = {0, 0, 0})}), Documentation(info = "<html><p>
Performs an n-dimensional interpolation table lookup where n=4. The table is a sampled representation of N variables among the function. The breakpoint sets associates input values with positions in the table.<br>The 1-D Lookup Table, 2-D Lookup Table and n-D Lookup Table compute the n-variable sampling representation of a function:
</p>
<p>
<span data-w-e-type=\"formula\" data-w-e-is-void data-w-e-is-inline data-value=\"y=F(x_1,x_2,x_3,...,x_N)\"></span><br>Where function F is an empirical function.
</p>
<p>
The module maps the input to the output value by finding or inserting a table of values that you defined using the module parameters. The Homogeneous (constant), Linear (linear point-slope), Nearest, Akima spline, Fritsch-Butland spline, &nbsp;Steffen spline interpolation methods and the Homogeneous (constant), Linear (linear point-slope) extrapolation methods are supported.
</p>
<p>
The 3DLookupTable is obtained by superimposing and expanding 2DLookupTable. Each page of the 3DLookupTable is a 2DLookupTable.
</p>
<p>
For example, when the breakPoints1 is {-1,0,1.2}, the breakPoints2 is {-2.3, -1.07, 0.05} and the corresponding value is {1, 2, 3, 4, 5, 6, 7, 8, 9},you can set the tableData {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LookupTable2D.png\"
     alt=\"LookupTable2D.png\">
</div>
<p>
In the following module, the breakPoints1 (u1) &nbsp;is identified by the first column of each page of the table, the breakPoints2 (u2) is identified by the first row of each page of the table, the breakPoints3 (u3) is identified by the pages of each block, the breakPoints4 (u4) is identified by the blocks of the table, and the tableData is identified by the others.
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LookupTable4D.png\"
     alt=\"LookupTable4D.png\">
</div>
<p>
For 4D lookup table import, the CSV data must be consistent with the breakpoint definition:
</p>
<ul><li>
breakPoints1, breakPoints2, breakPoints3, and breakPoints4 define the sampling positions of the four input dimensions.</li>
<li>
All breakpoint vectors must be strictly monotonically increasing.</li>
<li>
The total number of table values must equal length(breakPoints1) * length(breakPoints2) * length(breakPoints3) * length(breakPoints4).</li>
<li>
Conceptually, the 4D lookup table can be understood as a stack of 3D tables. In each page, the first column identifies breakPoints1, the first row identifies breakPoints2, the pages identify breakPoints3, and the outer blocks identify breakPoints4.</li>
<li>
The table value at each grid point corresponds to the combination (breakPoints1[i], breakPoints2[j], breakPoints3[k], breakPoints4[m]).</li>
<li>
In the current CSV implementation, the file may be stored as a serialized representation of the 4D table, where the breakpoint vectors are stored in separate columns and the table values are stored as a flattened sequence in one dedicated column.</li>
<li>
Therefore, the order of values in the tableData column must exactly match the internal storage/flattening rule used by the block implementation.</li>
<li>
Header rows and unsupported empty cells should be avoided in the CSV file.</li>
</ul><ul><li>
The breakpoint ranges should be chosen to cover the expected operating range of the inputs as much as possible in order to reduce unwanted extrapolation effects.</li>
</ul><p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"></span>
</p>
</html>"          ));

    end LookupTable4D;

    annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},
  grid={2,2}),graphics = {Rectangle(origin={0,0},
  lineColor={200,200,200},
  fillColor={248,248,248},
  fillPattern=FillPattern.HorizontalCylinder,
  extent={{-100,-100},{100,100}},
  radius=25), Rectangle(origin={0,0},
  lineColor={128,128,128},
  extent={{-100,-100},{100,100}},
  radius=25), Rectangle(origin={2,-51},
  lineColor={95,95,95},
  fillColor={235,235,235},
  fillPattern=FillPattern.Solid,
  extent={{-78,25},{78,-25}}), Rectangle(origin={2,-1},
  lineColor={95,95,95},
  fillColor={235,235,235},
  fillPattern=FillPattern.Solid,
  extent={{-78,25},{78,-25}}), Rectangle(origin={2,49},
  lineColor={95,95,95},
  fillColor={235,235,235},
  fillPattern=FillPattern.Solid,
  extent={{-78,25},{78,-25}}), Line(origin={-28,-1},
  points={{0,75},{0,-75}},
  color={95,95,95}), Line(origin={24,-1},
  points={{0,75},{0,-75}},
  color={95,95,95})}));
    end NTables;

  package Internal "Internal external object definitions for table functions that should not be directly utilized by the user"
    extends Modelica.Icons.InternalPackage;
    partial block CombiTable2DBase "Base class for variants of table look-up in two dimensions"
      parameter Boolean tableOnFile=false
        "= true, if table is defined on file or in function usertab" 
        annotation (Dialog(group="Table data definition"));
      parameter Real table[:, :] = fill(0.0, 0, 2)
        "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0, 0; 0, 1])" 
        annotation (Dialog(group="Table data definition",enable=not tableOnFile));
      parameter String tableName="NoName"
        "Table name on file or in function usertab (see docu)" 
        annotation (Dialog(group="Table data definition",enable=tableOnFile));
      parameter String fileName="NoName" "File where matrix is stored" 
        annotation (Dialog(
          group="Table data definition",
          enable=tableOnFile,
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)",
              caption="Open file in which table is present")));
      parameter Boolean verboseRead=true
        "= true, if info message that file is loading is to be printed" 
        annotation (Dialog(group="Table data definition",enable=tableOnFile));
      parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation" 
        annotation (Dialog(group="Table data interpretation"));
      parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
        "Extrapolation of data outside the definition range" 
        annotation (Dialog(group="Table data interpretation"));
      parameter Boolean verboseExtrapolation=false
        "= true, if warning messages are to be printed if table input is outside the definition range" 
        annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
      final parameter Real u_min[2]=getTable2DAbscissaUmin(tableID)
        "Minimum abscissa value defined in table";
      final parameter Real u_max[2]=getTable2DAbscissaUmax(tableID)
        "Maximum abscissa value defined in table";
      protected
        parameter Modelica.Blocks.Types.ExternalCombiTable2D tableID=
          Modelica.Blocks.Types.ExternalCombiTable2D(
            if tableOnFile then tableName else "NoName",
            if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
            table,
            smoothness,
            extrapolation,
            if tableOnFile then verboseRead else false) "External table object";
      equation
        if tableOnFile then
          assert(tableName <> "NoName",
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0,
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
      annotation(Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
      Line(points={{0.0,40.0},{0.0,-40.0}}),
      Line(points={{-60.0,40.0},{-30.0,20.0}}),
      Line(points={{-30.0,40.0},{-60.0,20.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0.0},{-32.3077,20.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20.0},{-32.3077,0.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30.0,20.0},{0.0,40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0.0,20.0},{30.0,40.0}}),
      Rectangle(origin={-2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20.0},{62.3077,40.0}})}));
    end CombiTable2DBase;
    partial block CombiTable2DTBase "Base class for variants of tunable parameter table look-up in two dimensions"
      parameter Boolean tableOnFile=false
        "= true, if table is defined on file or in function usertab" 
        annotation (Dialog(group="Table data definition"));
      parameter Real table[:, :] = fill(0.0, 0, 2)
        "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0, 0; 0, 1])" 
        annotation (Dialog(group="Table data definition",enable=not tableOnFile));
      parameter String tableName="NoName"
        "Table name on file or in function usertab (see docu)" 
        annotation (Dialog(group="Table data definition",enable=tableOnFile));
      parameter String fileName="NoName" "File where matrix is stored" 
        annotation (Dialog(
          group="Table data definition",
          enable=tableOnFile,
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)",
              caption="Open file in which table is present")));
      parameter Boolean verboseRead=true
        "= true, if info message that file is loading is to be printed" 
        annotation (Dialog(group="Table data definition",enable=tableOnFile));
      parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation" 
        annotation (Dialog(group="Table data interpretation"));
      parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
        "Extrapolation of data outside the definition range" 
        annotation (Dialog(group="Table data interpretation"));
      parameter Boolean verboseExtrapolation=false
        "= true, if warning messages are to be printed if table input is outside the definition range" 
        annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
      final parameter Real u_min[2](fixed = false)
        "Minimum abscissa value defined in table";
      final parameter Real u_max[2](fixed = false)
        "Maximum abscissa value defined in table";
      final parameter Real tableT[:,:] = fill(0.0, 0, 2);
      protected
        parameter Modelica.Blocks.Types.ExternalCombiTable2D tableID=
          Modelica.Blocks.Types.ExternalCombiTable2D(
            "tunable",
            "tunable",
            tableT,
            0,
            0,
            false) "External table object";
      initial algorithm
        initCombiTable2DT(
            if tableOnFile then tableName else "NoName",
            if tableOnFile and loadResource(fileName) <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then loadResource(fileName) else "NoName",
            table,
            smoothness,
            extrapolation,
            if tableOnFile then verboseRead else false,
            tableID);
        u_min := getTable2DAbscissaUmin(tableID);
        u_max := getTable2DAbscissaUmax(tableID);
      equation
        if tableOnFile then
          assert(tableName <> "NoName",
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0,
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
      annotation(Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
      Line(points={{0.0,40.0},{0.0,-40.0}}),
      Line(points={{-60.0,40.0},{-30.0,20.0}}),
      Line(points={{-30.0,40.0},{-60.0,20.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0.0},{-32.3077,20.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20.0},{-32.3077,0.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30.0,20.0},{0.0,40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0.0,20.0},{30.0,40.0}}),
      Rectangle(origin={-2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20.0},{62.3077,40.0}})}));
    end CombiTable2DTBase;
    function readTimeTableData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      input Boolean forceRead = false
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      output Real readSuccess "Table read success";
      input Boolean verboseRead = true
        "= true: Print info message; = false: No info message";
      external "C" readSuccess = ModelicaStandardTables_CombiTimeTable_read(tableID, forceRead, verboseRead) 
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTimeTableData;

    pure function getTimeTableValue
      "Interpolate 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          noDerivative=nextTimeEvent,
          noDerivative=pre_nextTimeEvent) = getDerTimeTableValue);
    end getTimeTableValue;
    pure function getTimeTableValue_vec
      "Interpolate 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer ncol "total cols to be interpolated";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y[ncol] "Interpolated value";
    external "C" ModelicaStandardTables_CombiTimeTable_getValue_vec(tableID, ncol, timeIn, nextTimeEvent, pre_nextTimeEvent, y) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(derivative(
      noDerivative = nextTimeEvent,
      noDerivative = pre_nextTimeEvent) = getDerTimeTableValue_vec);
    end getTimeTableValue_vec;

    pure function getTimeTableValueNoDer
      "Interpolate 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableValueNoDer;
    pure function getTimeTableValueNoDer_vec
      "Interpolate 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer ncol "total cols to be interpolated";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y[ncol] "Interpolated value";
    external "C" ModelicaStandardTables_CombiTimeTable_getValue_vec(tableID, ncol, timeIn, nextTimeEvent, pre_nextTimeEvent, y) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableValueNoDer_vec;

    pure function getTimeTableValueNoDer2
      "Interpolate 1-dim. table where first column is time (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          noDerivative=nextTimeEvent,
          noDerivative=pre_nextTimeEvent) = getDerTimeTableValueNoDer);
    end getTimeTableValueNoDer2;
    pure function getTimeTableValueNoDer2_vec
      "Interpolate 1-dim. table where first column is time (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer ncol "total cols to be interpolated";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y[ncol] "Interpolated value";
    external "C" ModelicaStandardTables_CombiTimeTable_getValue_vec(tableID, ncol, timeIn, nextTimeEvent, pre_nextTimeEvent, y) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(derivative(
      noDerivative = nextTimeEvent,
      noDerivative = pre_nextTimeEvent) = getDerTimeTableValueNoDer_vec);
    end getTimeTableValueNoDer2_vec;

    pure function getDerTimeTableValue
      "Derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          order=2,
          noDerivative=nextTimeEvent,
          noDerivative=pre_nextTimeEvent) = getDer2TimeTableValue);
    end getDerTimeTableValue;
    pure function getDerTimeTableValue_vec
      "Derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer ncol "total cols to be interpolated";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y[ncol] "Derivative of interpolated value";
    external "C" ModelicaStandardTables_CombiTimeTable_getDerValue_vec(tableID, ncol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn, der_y) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(derivative(
      order = 2,
      noDerivative = nextTimeEvent,
      noDerivative = pre_nextTimeEvent) = getDer2TimeTableValue_vec);
    end getDerTimeTableValue_vec;

    pure function getDerTimeTableValueNoDer
      "Derivative of interpolated 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTimeTableValueNoDer;
    pure function getDerTimeTableValueNoDer_vec
      "Derivative of interpolated 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer ncol "total cols to be interpolated";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y[ncol] "Derivative of interpolated value";
    external "C" ModelicaStandardTables_CombiTimeTable_getDerValue_vec(tableID, ncol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn, der_y) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTimeTableValueNoDer_vec;

    pure function getDer2TimeTableValue
      "Second derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      input Real der2_timeIn "Second derivative of (scaled) time value";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTimeTable_getDer2Value(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn, der2_timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2TimeTableValue;
    pure function getDer2TimeTableValue_vec
      "Second derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer ncol "total cols to be interpolated";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      input Real der2_timeIn "Second derivative of (scaled) time value";
      output Real der2_y[ncol] "Second derivative of interpolated value";
    external "C" ModelicaStandardTables_CombiTimeTable_getDer2Value_vec(tableID, ncol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn, der2_timeIn, der2_y) 
      annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaStandardTables.h\"", Library = {"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2TimeTableValue_vec;

    pure function getTimeTableTmin
      "Return minimum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      output Real timeMin "Minimum abscissa value in table";
      external "C" timeMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmin;
    pure function getTimeTableTmax
      "Return maximum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      output Real timeMax "Maximum abscissa value in table";
      external "C" timeMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmax;
    function readTable1DData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Boolean forceRead = false
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      input Boolean verboseRead = true
        "= true: Print info message; = false: No info message";
      output Real readSuccess "Table read success";
      external "C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead) 
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTable1DData;

    pure function getNextTimeEvent
      "Return next time event value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Real timeIn "(Scaled) time value";
      output Real nextTimeEvent "(Scaled) next time event in table";
      external "C" nextTimeEvent = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(tableID, timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getNextTimeEvent;

    pure function getTable1DValue "Interpolate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable1DValue);
    end getTable1DValue;
    pure function getTable1DValueNoDer
      "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DValueNoDer;
    pure function getTable1DValueNoDer2
      "Interpolate 1-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable1DValueNoDer);
    end getTable1DValueNoDer2;

    pure function getDerTable1DValue
      "Derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(order=2) = getDer2Table1DValue);
    end getDerTable1DValue;
    pure function getDerTable1DValueNoDer
      "Derivative of interpolated 1-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable1DValueNoDer;

    pure function getDer2Table1DValue
      "Second derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      input Real der2_u " Second derivative of abscissa value";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTable1D_getDer2Value(tableID, icol, u, der_u, der2_u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2Table1DValue;

    pure function getTable1DAbscissaUmin
      "Return minimum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      output Real uMin "Minimum abscissa value in table";
      external "C" uMin = ModelicaStandardTables_CombiTable1D_minimumAbscissa(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmin;

    pure function getTable1DAbscissaUmax
      "Return maximum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      output Real uMax "Maximum abscissa value in table";
      external "C" uMax = ModelicaStandardTables_CombiTable1D_maximumAbscissa(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmax;
    function readTable2DData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Boolean forceRead = false
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      input Boolean verboseRead = true
        "= true: Print info message; = false: No info message";
      output Real readSuccess "Table read success";
      external "C" readSuccess = ModelicaStandardTables_CombiTable2D_read(tableID, forceRead, verboseRead) 
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTable2DData;

    pure function getTable2DValue "Interpolate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable2DValue);
    end getTable2DValue;

    pure function getTable2DValueNoDer
      "Interpolate 2-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DValueNoDer;

    pure function getTable2DValueNoDer2
      "Interpolate 2-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable2DValueNoDer);
    end getTable2DValueNoDer2;

    pure function getDerTable2DValue
      "Derivative of interpolated 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(order=2) = getDer2Table2DValue);
    end getDerTable2DValue;

    pure function getDerTable2DValueNoDer
      "Derivative of interpolated 2-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable2DValueNoDer;

    pure function getDer2Table2DValue
      "Second derivative of interpolated 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      input Real der2_u1 "Second derivative of first independent variable";
      input Real der2_u2 "Second derivative of second independent variable";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTable2D_getDer2Value(tableID, u1, u2, der_u1, der_u2, der2_u1, der2_u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2Table2DValue;

    pure function getTable2DAbscissaUmin
      "Return minimum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      output Real uMin[2] "Minimum abscissa value in table";
      external "C" ModelicaStandardTables_CombiTable2D_minimumAbscissa(tableID, uMin) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DAbscissaUmin;

    pure function getTable2DAbscissaUmax
      "Return maximum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      output Real uMax[2] "Maximum abscissa value in table";
      external "C" ModelicaStandardTables_CombiTable2D_maximumAbscissa(tableID, uMax) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DAbscissaUmax;
    pure function initCombiTimeTableT "Initialize tunable parameter table where first column is time"
      extends Modelica.Icons.Function;
      input String tableName "Table name";
      input String fileName "File name";
      input Real table[:, :];
      input Units.SI.Time startTime;
      input Integer columns[:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation;
      input Units.SI.Time shiftTime=0.0;
      input Modelica.Blocks.Types.TimeEvents timeEvents=Modelica.Blocks.Types.TimeEvents.Always;
      input Boolean verboseRead=true "= true: Print info message; = false: No info message";
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Units.SI.Time timeScale;
      output Units.SI.Time timeScaleTwin;
      external "C" timeScaleTwin = ModelicaStandardTables_CombiTimeTableT_init3(
              fileName,
              tableName,
              table,
              size(table, 1),
              size(table, 2),
              startTime,
              columns,
              size(columns, 1),
              smoothness,
              extrapolation,
              shiftTime,
              timeEvents,
              verboseRead,
              tableID,
              timeScale);
    end initCombiTimeTableT;
    pure function initCombiTable1DT "Initialize 1-dim. tunable parameter table defined by matrix"
      extends Modelica.Icons.Function;
      input String tableName "Table name";
      input String fileName "File name";
      input Real table[:, :];
      input Integer columns[:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
      input Boolean verboseRead=true "= true: Print info message; = false: No info message";
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      external "C" ModelicaStandardTables_CombiTable1DT_init3(
              fileName,
              tableName,
              table,
              size(table, 1),
              size(table, 2),
              columns,
              size(columns, 1),
              smoothness,
              extrapolation,
              verboseRead,
              tableID);
    end initCombiTable1DT;
    pure function initCombiTable2DT "Initialize 2-dim. tunable parameter table defined by matrix"
      extends Modelica.Icons.Function;
      input String tableName "Table name";
      input String fileName "File name";
      input Real table[:, :];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
      input Boolean verboseRead=true "= true: Print info message; = false: No info message";
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      external "C" ModelicaStandardTables_CombiTable2DT_init3(
              fileName,
              tableName,
              table,
              size(table, 1),
              size(table, 2),
              smoothness,
              extrapolation,
              verboseRead,
              tableID);
    end initCombiTable2DT;
  end Internal;

  annotation (Documentation(info="<html>
<p>This package contains blocks for one- and two-dimensional interpolation in tables.</p>
<h4>Special interest topic: Statically stored tables for real-time simulation targets</h4>
<p>Especially for use on real-time platform targets (e.g., HIL-simulators) with <strong>no file system</strong>, it is possible to statically
store tables using a function &quot;usertab&quot; in a file conventionally named &quot;usertab.c&quot;. This can be more efficient than providing the tables as Modelica parameter arrays.</p>
<p>This is achieved by providing the tables in a specific structure as C-code and compiling that C-code together with the rest of the simulation model into a binary
that can be executed on the target platform. The &quot;Resources/Data/Tables/&quot; subdirectory of the MSL installation directory contains the files
<a href=\"modelica://Modelica/Resources/Data/Tables/usertab.c\">&quot;usertab.c&quot;</a> and <a href=\"modelica://Modelica/Resources/Data/Tables/usertab.h\">&quot;usertab.h&quot;</a>
that can be used as a template for own developments. While &quot;usertab.c&quot; would be typically used unmodified, the
&quot;usertab.h&quot; needs to adapted for the own needs.</p>
<p>In order to work it is necessary that the compiler pulls in the &quot;usertab.c&quot; file. Different Modelica tools might provide different mechanisms to do so.
Please consult the respective documentation/support for your Modelica tool.</p>
<p>A possible (though slightly makeshift) approach is to pull in the required files by utilizing a &quot;dummy&quot;-function that uses the Modelica external function
interface to include the required &quot;usertab.c&quot;. An example how this can be done is given below.</p>
<blockquote><pre>
model ExampleCTable \"Example utilizing the usertab.c interface\"
  extends Modelica.Icons.Example;
  parameter Real dummy(fixed=false) \"Dummy parameter\" annotation(HideResult=true);
  Modelica.Blocks.Tables.CombiTable1Dv table(tableOnFile=true, tableName=\"TestTable_1D_a\")
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
protected
  encapsulated impure function getUsertab \"External dummy function to include \\\"usertab.c\\\"\"
    input Real dummy_u[:];
    output Real dummy_y;
    external \"C\" dummy_y = mydummyfunc(dummy_u);
    annotation(IncludeDirectory=\"modelica://Modelica/Resources/Data/Tables\",
           Include = \"#include \"usertab.c\"
double mydummyfunc(double* dummy_in) {
   return 0;
}
\");
  end getUsertab;
initial equation
  dummy = getUsertab(table.y);
equation
  connect(clock.y, table.u[1]) annotation (Line(points={{-59,10},{-42,10}}, color={0,0,127}));
  annotation (experiment(StartTime=0, StopTime=5), uses(Modelica(version=\"4.0.0\")));
end ExampleCTable;
</pre></blockquote>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-76,-26},{80,-76}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,24},{80,-26}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,74},{80,24}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-28,74},{-28,-76}},
          color={95,95,95}),
        Line(
          points={{24,74},{24,-76}},
          color={95,95,95})}));

  package Utilities
  "Utility functions that should not be directly utilized by the user"
  annotation(Protection(hideFromBrowser=false ));
    extends Modelica.Icons.UtilitiesPackage;
    function arr2D2vec "Expand the matrix into a vector"
      input Real mat[:,:];
      output Real vec[:];
      protected
        Integer size1 = size(mat, 1);
        Integer size2 = size(mat, 2);
        Integer totalSize;
        Integer index;
      algorithm
        totalSize := size1 * size2;
        vec := zeros(totalSize);
        index := 1;
        for i in 1:size1 loop
          for j in 1:size2 loop
            vec[index] := mat[i,j];
            index := index + 1;
          end for;
        end for;
    end arr2D2vec;
    function arr3D2vec "Expand the 3D-Array into a vector"
      input Real arr[:,:,:];
      output Real vec[:];
      protected
        Integer size1 = size(arr, 1);
        Integer size2 = size(arr, 2);
        Integer size3 = size(arr, 3);
        Integer totalSize;
        Integer index;
      algorithm
        totalSize := size1 * size2 * size3;
        vec := zeros(totalSize);
        index := 1;
        for i in 1:size2 loop
          for j in 1:size3 loop
            for k in 1:size1 loop
              vec[index] := arr[k,i,j];
              index := index + 1;
            end for;
          end for;
        end for;
    end arr3D2vec;
    function arr4D2vec "Expand the 4D-Array into a vector"
      input Real arr[:,:,:,:];
      output Real vec[:];
    protected
      Integer size1 = size(arr, 1);
      Integer size2 = size(arr, 2);
      Integer size3 = size(arr, 3);
      Integer size4 = size(arr, 4);
      Integer totalSize;
      Integer index;
    algorithm
      totalSize := size1 * size2 * size3 * size4;
      vec := zeros(totalSize);
      index := 1;
      for i in 1:size2 loop          // dim2: slowest
        for j in 1:size3 loop        // dim3
          for m in 1:size4 loop      // dim4
            for k in 1:size1 loop    // dim1: fastest
              vec[index] := arr[k, i, j, m];
              index := index + 1;
            end for;
          end for;
        end for;
      end for;
    end arr4D2vec;
  end Utilities;
  package Types "Library of external objects and types with choices, especially to build menus"
  annotation(Protection(hideFromBrowser=false ));
  extends Modelica.Icons.TypesPackage;

    type InterpolationMethod = enumeration(
      Hold  "Hold the last value",
      Nearest  "Take the nearest value",
      Linear  "Linear interpolation",
      Akima  "Akima spline interpolation",
      FritschButland  "Fritsch-Butland spline interpolation",
      Steffen  "Steffen spline interpolation") "Interpolation Method";
    type ExtrapolationMethod = enumeration(
      Hold  "Hold the last value",
      Linear  "Linear extrapolation",
      None  "No extrapolation") "Extrapolation Method";
    class ExternalNDTable "External object of NDTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input Integer ndims;
        input Real data[:];
        output Types.ExternalNDTable externalTable;
      external "C" externalTable = ModelicaNDTable_open(
      ndims, data, size(data, 1)) annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input Types.ExternalNDTable externalTable;
      external "C" ModelicaNDTable_close(externalTable) annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end ExternalNDTable;
    class External1DTable "External object of 1DTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input String fileName;
        input Integer tableCol;
        input Integer breakCols[:];
        input Real break1[:];
        input Integer bp_sizes[:];
        input Real table[:];
        output External1DTable externalTable;
      external "C" externalTable = TY_Modelica1DTable(
      fileName, tableCol, breakCols,
      break1, bp_sizes,
      table, size(table, 1)) 
      annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input External1DTable externalTable;
      external "C" ModelicaNDTable_close(externalTable) annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end External1DTable;
    class External2DTable "External object of 2DTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input String fileName;
        input Integer tableCol;
        input Integer breakCols[:];
        input Real break1[:];
        input Real break2[:];
        input Integer bp_sizes[:];
        input Real table[:];
        output External2DTable externalTable;
      external "C" externalTable = TY_Modelica2DTable(
      fileName, tableCol, breakCols,
      break1, break2, bp_sizes,
      table, size(table, 1)) 
      annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input External2DTable externalTable;
      external "C" ModelicaNDTable_close(externalTable) annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end External2DTable;
    class External3DTable "External object of 3DTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input String fileName;
        input Integer tableCol;
        input Integer breakCols[:];
        input Real break1[:];
        input Real break2[:];
        input Real break3[:];
        input Integer bp_sizes[:];
        input Real table[:];
        output External3DTable externalTable;
      external "C" externalTable = TY_Modelica3DTable(
      fileName, tableCol, breakCols,
      break1, break2, break3, bp_sizes,
      table, size(table, 1)) 
      annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input External3DTable externalTable;
      external "C" ModelicaNDTable_close(externalTable) annotation (
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end External3DTable;
    class External4DTable "External object of 4DTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input String fileName;
        input Integer tableCol;
        input Integer breakCols[:];   // length=4
        input Real break1[:];
        input Real break2[:];
        input Real break3[:];
        input Real break4[:];
        input Integer bp_sizes[:];    // length=4
        input Real table[:];
        output External4DTable externalTable;

      external "C" externalTable = TY_Modelica4DTable(
        fileName, tableCol, breakCols,
        break1, break2, break3, break4,
        bp_sizes,
        table, size(table, 1)) 
        annotation(
        Include = "#include <ModelicaNDTable.c>",
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end constructor;

      function destructor "Close table"
        input External4DTable externalTable;
      external "C" ModelicaNDTable_close(externalTable) annotation (
          Include = "#include <ModelicaNDTable.c>",
          IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end External4DTable;
    function evaluate "The universal interface to do interpolation"
      input Tables.Types.ExternalNDTable table;
      input Real[:] params;
      input Tables.Types.InterpolationMethod interpMethod;
      input Tables.Types.ExtrapolationMethod extrapMethod;
      output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod) annotation(
      Include = "#include <ModelicaNDTable.c>",
      IncludeDirectory = "modelica://Tables/Resources/C-Sources");
    end evaluate;
    function evaluate1D "1D interface to do interpolation"
      input External1DTable table;
      input Real[:] params;
      input InterpolationMethod interpMethod;
      input ExtrapolationMethod extrapMethod;
      output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod) annotation(
      Include = "#include <ModelicaNDTable.c>",
      IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
    end evaluate1D;
    function evaluate2D "2D interface to do interpolation"
      input External2DTable table;
      input Real[:] params;
      input InterpolationMethod interpMethod;
      input ExtrapolationMethod extrapMethod;
      output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod) annotation(
      Include = "#include <ModelicaNDTable.c>",
      IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
    end evaluate2D;
    function evaluate3D "3D interface to do interpolation"
      input External3DTable table;
      input Real[:] params;
      input InterpolationMethod interpMethod;
      input ExtrapolationMethod extrapMethod;
      output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod) annotation(
      Include = "#include <ModelicaNDTable.c>",
      IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
    end evaluate3D;
    function evaluate4D "4D interface to do interpolation"
      input External4DTable table;
      input Real[:] params;
      input InterpolationMethod interpMethod;
      input ExtrapolationMethod extrapMethod;
      output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod) annotation(
      Include = "#include <ModelicaNDTable.c>",
      IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
    end evaluate4D;
  end Types;
end Tables;