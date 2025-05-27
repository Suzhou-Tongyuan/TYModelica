function tempInterpol1 
  "Temporary function for linear interpolation "
  extends Modelica.Icons.Function;

  input Real u "input value (first column of table)";
  input Real table[:, :] "table to be interpolated";
  input Integer icol "column of table to be interpolated";
  output Real y "interpolated input value (icol column of table)";
protected
  Integer i;
  Integer n "number of rows of table";
  Real u1;
  Real u2;
  Real y1;
  Real y2;
algorithm
  n := size(table, 1);

  if n <= 1 then
    y := table[1, icol];

  else
    // Search interval

    if u <= table[1, 1] then
      i := 1;

    else
      i := 2;
      // Supports duplicate table[i, 1] values
      // in the interior to allow discontinuities.
      // Interior means that
      // if table[i, 1] = table[i+1, 1] we require i>1 and i+1<n

      while i < n and u >= table[i, 1] loop
        i := i + 1;

      end while;
      i := i - 1;

    end if;

    // Get interpolation data
    u1 := table[i, 1];
    u2 := table[i + 1, 1];
    y1 := table[i, icol];
    y2 := table[i + 1, icol];

    assert(u2 > u1, "Table index must be increasing");
    // Interpolate
    y := y1 + (y2 - y1)*(u - u1)/(u2 - u1);

  end if;

  annotation (Documentation(info="<html>

</html>"), 
  obsolete = "Obsolete function");
end tempInterpol1;