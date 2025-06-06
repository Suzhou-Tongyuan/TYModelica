﻿within Modelica.Electrical.Analog.Sources;
model PulseCurrent "Pulse current source"
  parameter SI.Current I(start=1) "Amplitude of pulse";
  parameter Real width(
    final min=Modelica.Constants.small, 
    final max=100, 
    start=50) "Width of pulse in % of period";
  parameter SI.Time period(final min=Modelica.Constants.small, start=1) 
    "Time for one period";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Pulse 
      signalSource(
      final amplitude=I, 
      final width=width, 
      final period=period));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-80,-67},{-50,-67},{-50,73},{-10, 
              73},{-10,-67},{30,-67},{30,73},{70,73}}, color={192,192,192})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", 
        info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

end PulseCurrent;