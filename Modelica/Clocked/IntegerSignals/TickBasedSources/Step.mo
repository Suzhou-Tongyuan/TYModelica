﻿within Modelica.Clocked.IntegerSignals.TickBasedSources;
block Step "Generate step signal of type Integer"
    extends Interfaces.PartialClockedSO;
  parameter Integer height = 1 "Height of step";
  parameter Integer offset = 0 "Offset of output signal y";
  parameter Integer startTick(min=1) = 1 
    "Output y = offset for clock tick < startTick";
protected
  Integer counter(start=0);
equation
  // stop counter after counter = startTick to avoid integer overflow for long running simulations
  counter = if previous(counter) < startTick then previous(counter) + 1 else previous(counter);
  y = offset + (if counter < startTick then 0 else height);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, color={255,128,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,-150},{150,-110}}, 
          textString="startTick=%startTick"), 
        Ellipse(
          extent={{-6,56},{6,44}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-86,-64},{-74,-76}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-46,-64},{-34,-76}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{34,56},{46,44}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{74,56},{86,44}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
                          Diagram(coordinateSystem(preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-80,88},{-86,68},{-74,68},{-80,88}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,68},{-80,-80}}, color={95,95,95}), 
        Line(
          points={{-80,-18},{0,-18},{0,50},{72,50}}, 
          color={255,128,0}, 
          thickness=0.5, 
          pattern=LinePattern.Dot), 
        Line(points={{-90,-70},{82,-70}}, color={95,95,95}), 
        Polygon(
          points={{90,-70},{70,-66},{70,-74},{90,-70}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{66,-78},{92,-88}}, 
          textString="tick"), 
        Text(
          extent={{-21,-76},{26,-88}}, 
          textString="startTick"), 
        Line(points={{0,-17},{0,-71}}, color={95,95,95}), 
        Text(
          extent={{-60,-36},{-12,-48}}, 
          textString="offset"), 
        Line(points={{-13,50},{-13,-17}}, color={95,95,95}), 
        Polygon(
          points={{2,50},{-19,50},{2,50}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-13,50},{-16,37},{-9,37},{-13,50}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-58,22},{-12,10}}, 
          textString="height"), 
        Polygon(
          points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-13,-18},{-13,-70}}, color={95,95,95}), 
        Polygon(
          points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-78,96},{-44,80}}, 
          textString="y"), 
        Ellipse(
          extent={{-86,-12},{-74,-24}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-6,56},{6,44}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-46,-12},{-34,-24}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{30,56},{42,44}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{66,56},{78,44}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
The Integer output y is a step signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/IntegerSignals/TickBasedSources_Step.png\" alt=\"TickBasedSources_Step.png\">
</div>

<h4>Example</h4>
<p>
See model <a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.TickBasedStep\">Modelica.Clocked.Examples.Elementary.IntgerSignals.TickBasedStep</a>.
<br>
</p>
</html>"));
end Step;