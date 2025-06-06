﻿within Modelica.Clocked.IntegerSignals.Sampler.Utilities;
block UpSample 
  "Upsample the clocked Integer input signal and provide it as clocked output signal"
  parameter Boolean inferFactor=true 
    "= true, if upsampling factor is inferred"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1 
    "Upsampling factor >= 1 (if inferFactor=false)" annotation(Evaluate=true, Dialog(enable=not inferFactor));
  Modelica.Blocks.Interfaces.IntegerInput u 
    "Connector of clocked, Integer input signal" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y 
    "Connector of clocked, Integer output signal (clock of y is faster as clock of u)" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Integer dummy annotation(HideResult=true);
  Boolean b(start=false);
  Boolean b_super(start=false);
  Integer u_super;
equation
  when Clock() then // clock of u
     dummy = u;
     b = not previous(b);
  end when;

  when Clock() then // clock of y
     b_super = superSample(b);
     if inferFactor then
        u_super = superSample(u);
     else
        u_super = superSample(u,factor);
     end if;
     y = if b_super <> previous(b_super) then u_super else 0;
  end when;

  annotation (
   defaultComponentName="upSample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Line(
          points={{-78,-60},{40,-60},{40,0},{40,0}}, 
          color={215,215,215}, 
          pattern=LinePattern.Dot), Line(points={{-80,-60},{-40,-60},{-40,-60},{-40,0}, 
              {-40,0},{0,0},{40,0},{40,80},{40,80},{40,80},{80,80},{80,0},{80,0}, 
              {100,0}},          color={255,128,0}, 
          pattern=LinePattern.Dot),                Line(
          points={{-80,-60},{-80,0},{-100,0}}, 
          color={255,128,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Ellipse(
          extent={{-95,-45},{-65,-75}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-83,-57},{-77,-63}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{25,96},{55,66}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{37,83},{43,77}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-55,16},{-25,-14}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-6,16},{24,-14}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{64,16},{94,-14}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          visible=not inferFactor, 
          extent={{-150,-100},{150,-140}}, 
          textString="%factor", 
          textColor={0,0,0}), 
        Line(
          points={{80,80},{120,80}}, 
          color={215,215,215}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20}, 
              {25,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}, 
          origin={-71,52}, 
          rotation=90)}), 
    Documentation(info="<html>
<p>
This block for Integer signals works similarly as the corresponding block for Real signals (see
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">RealSignals.Sampler.Utilities.UpSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.UpSample\">example</a> for this Integer block.
</p>

</html>"));
end UpSample;