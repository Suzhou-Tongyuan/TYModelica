within Modelica.Blocks;
package Interfaces
  "Library of connectors and partial models for input/output blocks"

  extends Modelica.Icons.InterfacesPackage;

  connector RealInput = input Real "'input Real' as connector" annotation (
    defaultComponentName="u",
    Icon(graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
      Text(
        textColor={0,0,127},
        extent={{-10.0,60.0},{-10.0,85.0}},
        textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));

  connector RealOutput = output Real "'output Real' as connector" annotation (
    defaultComponentName="y",
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        points={{-100.0,50.0},{0.0,0.0},{-100.0,-50.0}}),
      Text(
        textColor={0,0,127},
        extent={{30.0,60.0},{30.0,110.0}},
        textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));

  connector BooleanInput = input Boolean "'input Boolean' as connector" 
    annotation (
    defaultComponentName="u",
    Icon(graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{0,50},{100,0},{0,-50},{0,50}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-10,85},{-10,60}},
          textColor={255,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one input signal of type Boolean.
</p>
</html>"));

  connector BooleanOutput = output Boolean "'output Boolean' as connector" 
    annotation (
    defaultComponentName="y",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,50},{0,0},{-100,-50},{-100,50}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{30,110},{30,60}},
          textColor={255,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one output signal of type Boolean.
</p>
</html>"));

  connector IntegerInput = input Integer "'input Integer' as connector" 
    annotation (
    defaultComponentName="u",
    Icon(graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{0,50},{100,0},{0,-50},{0,50}},
          lineColor={255,127,0},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-10,85},{-10,60}},
          textColor={255,127,0},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one input signal of type Integer.
</p>
</html>"));

  connector IntegerOutput = output Integer "'output Integer' as connector" 
    annotation (
    defaultComponentName="y",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,50},{0,0},{-100,-50},{-100,50}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{30,110},{30,60}},
          textColor={255,127,0},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one output signal of type Integer.
</p>
</html>"));

  connector RealVectorInput = input Real
    "Real input connector used for vector of connectors" annotation (
    defaultComponentName="u",
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-10,85},{-10,60}},
          textColor={0,0,127},
          textString="%name"), Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Real input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialRealMISO\">PartialRealMISO</a>,
and has therefore a different icon as RealInput connector.
</p>
</html>"));

  connector IntegerVectorInput = input Integer
    "Integer input connector used for vector of connectors" annotation (
    defaultComponentName="u",
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-10,85},{-10,60}},
          textColor={255,128,0},
          textString="%name"), Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>

<p>
Integer input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialIntegerMISO\">PartialIntegerMISO</a>,
and has therefore a different icon as IntegerInput connector.
</p>
</html>"));

  connector BooleanVectorInput = input Boolean
    "Boolean input connector used for vector of connectors" annotation (
    defaultComponentName="u",
    Icon(graphics={Ellipse(
          extent={{-100,-100},{100,100}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=false,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-10,85},{-10,60}},
          textColor={255,0,255},
          textString="%name"), Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Boolean input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialBooleanMISO\">PartialBooleanMISO</a>,
and has therefore a different icon as BooleanInput connector.
</p>
</html>"));

  connector RealVectorOutput = output Real
    "Real output connector used for vector of connectors" annotation (
    defaultComponentName="y",
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-10,85},{-10,60}},
          textColor={0,0,127},
          textString="%name"), Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Real output connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Routing.DeMultiplex\">DeMultiplex</a>,
and has therefore a different icon as RealOutput connector.
</p>
</html>"));
  connector IntegerVectorOutput = output Integer
    "Integer output connector used for vector of connectors" annotation(
    defaultComponentName = "y",
    Icon(graphics = {Ellipse(
    extent = {{-100, 100}, {100, -100}},
    lineColor = {255, 128, 0},
    fillColor = {255, 128, 0},
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}},
    preserveAspectRatio = true,
    initialScale = 0.2)),
    Diagram(coordinateSystem(
    preserveAspectRatio = false,
    initialScale = 0.2,
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{-10, 85}, {-10, 60}},
    textColor = {255, 128, 0},
    textString = "%name"), Ellipse(
    extent = {{-50, 50}, {50, -50}},
    lineColor = {255, 128, 0},
    fillColor = {255, 128, 0},
    fillPattern = FillPattern.Solid)}),
    Documentation(info = "<html>
<p>
Integer output connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Routing.DeMultiplex\">DeMultiplex</a>,
and has therefore a different icon as IntegerOutput connector.
</p>
</html>"    ));
  connector BooleanVectorOutput = output Boolean
    "Boolean output connector used for vector of connectors" annotation(
    defaultComponentName = "y",
    Icon(graphics = {Ellipse(
    extent = {{-100, 100}, {100, -100}},
    lineColor = {255, 0, 255},
    fillColor = {255, 0, 255},
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}},
    preserveAspectRatio = true,
    initialScale = 0.2)),
    Diagram(coordinateSystem(
    preserveAspectRatio = false,
    initialScale = 0.2,
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{-10, 85}, {-10, 60}},
    textColor = {255, 0, 255},
    textString = "%name"), Ellipse(
    extent = {{-50, 50}, {50, -50}},
    lineColor = {255, 0, 255},
    fillColor = {255, 0, 255},
    fillPattern = FillPattern.Solid)}),
    Documentation(info = "<html>
<p>
Boolean output connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Routing.DeMultiplex\">DeMultiplex</a>,
and has therefore a different icon as BooleanOutput connector.
</p>
</html>"  ));
  block ExternalInput
    "Top-Level input connector that automatically inherits the type of the connected port"

    extends Modelica.Blocks.Icons.Block;

    Modelica.Blocks.Interfaces.RealOutput u "Connector of input signal" 
      annotation(
        __MWORKS(SpecialComponent(Name = "AutoInput")),
        Placement(transformation(extent = {{100, -10}, {120, 10}})),
        Documentation(info = "<html>
<p>
Input signal connector. Although declared as a
<code>RealOutput</code> for icon/placement purposes, its effective
type is resolved by the <code>__MWORKS</code> special-component
annotation at connection time, allowing it to inherit the type of the
connected port.
</p>
</html>"    ));

    annotation(
      __MWORKS(SpecialComponent(Name = "ExternalInput")),
      Documentation(info = "<html>
<p>
This block can be used as a <b>top-level input connector</b> and
<b>automatically inherits the type of the connected port</b>.
</p>

<h4>Purpose</h4>
<p>
<code>ExternalInput</code> provides a type-neutral input interface.
Instead of binding a concrete type (such as <code>Real</code>,
<code>Integer</code> or <code>Boolean</code>) at the definition stage,
it defers the type determination to the connection stage. As a result,
a single component definition can serve multiple signal types without
duplicating models for each type.
</p>

<h4>Core Behavior</h4>
<ul>
<li><b>Top-level input:</b> When used inside a model, it is exposed as
a top-level input of that model, and its variable value is supplied by
the simulation environment.</li>
<li><b>Type inheritance:</b> The concrete data type is not fixed at
definition time; it automatically inherits the type of the port it is
connected to. Therefore, when it is connected to multiple ports at the
same time, make sure that all connected ports have the same type.</li>
</ul>

<h4>Usage Constraints</h4>
<ul>
<li><b>Connection direction:</b> Can only be connected to an output
port or a non-directional port. It cannot be connected to another
input port.</li>
<li><b>Expandable connectors:</b> Must be connected to a declared
variable when linking to an expandable connector. Connecting to an
undeclared variable of an expandable connector is <b>not supported
yet</b>.</li>
</ul>

<h4>Typical Use Cases</h4>
<ul>
<li>Generic signal routing models that must support Real, Integer or
Boolean signals with a single definition.</li>
</ul>
</html>"    ));

  end ExternalInput;
  block ExternalOutput
    "Top-Level output connector that automatically inherits the type of the connected port"

    extends Modelica.Blocks.Icons.Block;

    Modelica.Blocks.Interfaces.RealInput y "Connector of output signal" 
      annotation(
        __MWORKS(SpecialComponent(Name = "AutoOutput")),
        Placement(transformation(extent = {{-140, -20}, {-100, 20}})),
        Documentation(info = "<html>
<p>
Output signal connector. Although declared as a
<code>RealInput</code> for icon/placement purposes, its effective
type is resolved by the <code>__MWORKS</code> special-component
annotation at connection time, allowing it to inherit the type of the
connected port.
</p>
</html>"    ));

    annotation(
      __MWORKS(SpecialComponent(Name = "ExternalOutput")),
      Documentation(info = "<html>
<p>
This block can be used as a <b>top-level output connector</b> and
<b>automatically inherits the type of the connected port</b>.
</p>

<h4>Purpose</h4>
<p>
<code>ExternalOutput</code> provides a type-neutral output interface.
Instead of binding a concrete type (such as <code>Real</code>,
<code>Integer</code> or <code>Boolean</code>) at the definition stage,
it defers the type determination to the connection stage. As a result,
a single component definition can serve multiple signal types without
duplicating models for each type.
</p>

<h4>Core Behavior</h4>
<ul>
<li><b>Top-level output:</b> When used inside a model, it is exposed as
a top-level output of that model, and its variable value can be read by
the simulation environment.</li>
<li><b>Type inheritance:</b> The concrete data type is not fixed at
definition time; it automatically inherits the type of the port it is
connected to.</li>
</ul>

<h4>Usage Constraints</h4>
<ul>
<li><b>Connection direction:</b> Can only be connected to an input port
or a non-directional port. It cannot be connected to another output
port.</li>
<li><b>Single connection:</b> Can only be connected to one output port
and can only accept one signal.</li>
<li><b>Expandable connectors:</b> Must be connected to a declared
variable when linking to an expandable connector. Connecting to an
undeclared variable of an expandable connector is <b>not supported
yet</b>.</li>
</ul>

<h4>Typical Use Cases</h4>
<ul>
<li>Generic signal routing models that must support Real, Integer or
Boolean signals with a single definition.</li>
</ul>
</html>"    ));

  end ExternalOutput;

  partial block SO "Single Output continuous control block"
    extends Modelica.Blocks.Icons.Block;

    RealOutput y "Connector of Real output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"));

  end SO;

  partial block MO "Multiple Output continuous control block"
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nout(min=1) = 1 "Number of outputs";
    RealOutput y[nout] "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal vector.
</p>
</html>"));

  end MO;

  partial block SISO "Single Input Single Output continuous control block"
    extends Modelica.Blocks.Icons.Block;

    RealInput u "Connector of Real input signal" annotation (Placement(transformation(origin={-120,0},
extent={{-20,-20},{20,20}})));
    RealOutput y "Connector of Real output signal" annotation (Placement(transformation(origin={110,0},
extent={{-10,-10},{10,10}})));
    annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
  end SISO;

  partial block SI2SO
    "2 Single Input / 1 Single Output continuous control block"
    extends Modelica.Blocks.Icons.Block;

    RealInput u1 "Connector of Real input signal 1" annotation (Placement(
          transformation(extent={{-140,40},{-100,80}})));
    RealInput u2 "Connector of Real input signal 2" annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
    RealOutput y "Connector of Real output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Documentation(info="<html>
<p>
Block has two continuous Real input signals u1 and u2 and one
continuous Real output signal y.
</p>
</html>"));

  end SI2SO;

  partial block SIMO "Single Input Multiple Output continuous control block"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer nout=1 "Number of outputs";
    RealInput u "Connector of Real input signal" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    RealOutput y[nout] "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Documentation(info="<html>
<p> Block has one continuous Real input signal and a
    vector of continuous Real output signals.</p>

</html>"));
  end SIMO;

  partial block MISO "Multiple Input Single Output continuous control block"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer nin=1 "Number of inputs";
    RealInput u[nin] "Connector of Real input signals" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    RealOutput y "Connector of Real output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has a vector of continuous Real input signals and
one continuous Real output signal.
</p>
</html>"));
  end MISO;

  partial block PartialRealMISO
    "Partial block with a RealVectorInput and a RealOutput signal"

    parameter Integer significantDigits(min=1) = 3
      "Number of significant digits to be shown in dynamic diagram layer for y" 
      annotation (Dialog(tab="Advanced"));
    parameter Integer nu(min=0) = 0 "Number of input connections" 
      annotation (Dialog(connectorSizing=true), HideResult=true);
    Modelica.Blocks.Interfaces.RealVectorInput u[nu] 
      annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
    Modelica.Blocks.Interfaces.RealOutput y 
      annotation (Placement(transformation(extent={{100,-17},{134,17}})));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.06), graphics={
          Text(
            extent={{110,-50},{300,-70}},
            textString=DynamicSelect(" ", String(y, significantDigits=
                significantDigits))),
          Text(
            extent={{-250,170},{250,110}},
            textString="%name",
            textColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,137,0},
            fillColor={255,255,255},
            borderPattern=BorderPattern.Raised,
            fillPattern=FillPattern.Solid)}));
  end PartialRealMISO;
  partial block MIMO "Multiple Input Multiple Output continuous control block"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer nin=1 "Number of inputs";
    parameter Integer nout=1 "Number of outputs";
    RealInput u[nin] "Connector of Real input signals" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    RealOutput y[nout] "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has a continuous Real input and a continuous Real output signal vector.
The signal sizes of the input and output vector may be different.
</p>
</html>"));
  end MIMO;
  partial block MIMOs
    "Multiple Input Multiple Output continuous control block with same number of inputs and outputs"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer n=1 "Number of inputs (= number of outputs)";
    RealInput u[n] "Connector of Real input signals" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    RealOutput y[n] "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has a continuous Real input and a continuous Real output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
  end MIMOs;

  partial block MI2MO
    "2 Multiple Input / Multiple Output continuous control block"
    extends Modelica.Blocks.Icons.Block;

    parameter Integer n=1 "Dimension of input and output vectors.";

    RealInput u1[n] "Connector 1 of Real input signals" annotation (Placement(
          transformation(extent={{-140,40},{-100,80}})));
    RealInput u2[n] "Connector 2 of Real input signals" annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
    RealOutput y[n] "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has two continuous Real input vectors u1 and u2 and one
continuous Real output vector y.
All vectors have the same number of elements.
</p>
</html>"));

  end MI2MO;
  partial block VI2VO
    "2 Vectors Input / 1 Vectors Output continuous control block"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n = 1 "length of vector";
    Modelica.Blocks.Interfaces.RealInput u1[n] "Connector of Real Vectors input signal 1" annotation (Placement(
          transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput u2[n] "Connector of Real Vectors input signal 2" annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "Connector of Real Vectors output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Documentation(info="<html><p>
Block has two continuous Real Vectors input signals u1[n] and u2[n] and one continuous Real Vectors output signal y.
</p>
</html>"  ));

  end VI2VO;

  partial block SignalSource "Base class for continuous signal source"
    extends SO;
    parameter Real offset=0 "Offset of output signal y";
    parameter SI.Time startTime=0 "Output y = offset for time < startTime";
    annotation (Documentation(info="<html>
<p>
Basic block for Real sources of package Blocks.Sources.
This component has one continuous Real output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
  end SignalSource;

  partial block SVcontrol "Single-Variable continuous controller"
    extends Modelica.Blocks.Icons.Block;

    RealInput u_s "Connector of setpoint input signal" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    RealInput u_m "Connector of measurement input signal" annotation (Placement(
          transformation(
          origin={0,-120},
          extent={{20,-20},{-20,20}},
          rotation=270)));
    RealOutput y "Connector of actuator output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has two continuous Real input signals and one
continuous Real output signal. The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
  end SVcontrol;

  partial block MVcontrol "Multi-Variable continuous controller"
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nu_s=1 "Number of setpoint inputs";
    parameter Integer nu_m=1 "Number of measurement inputs";
    parameter Integer ny=1 "Number of actuator outputs";
    RealInput u_s[nu_s] "Connector of setpoint input signals" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    RealInput u_m[nu_m] "Connector of measurement input signals" annotation (
        Placement(transformation(
          origin={0,-120},
          extent={{20,-20},{-20,20}},
          rotation=270)));
    RealOutput y[ny] "Connector of actuator output signals" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has two continuous Real input signal vectors and one
continuous Real output signal vector. The block is designed
to be used as base class for a corresponding controller.
</p>
</html>"));
  end MVcontrol;

  partial block DiscreteBlock "Base class of discrete control blocks"
    extends Modelica.Blocks.Icons.DiscreteBlock;

    parameter SI.Time samplePeriod(min=100*Modelica.Constants.eps, start=0.1)
      "Sample period of component";
    parameter SI.Time startTime=0 "First sample time instant";
  protected
    output Boolean sampleTrigger "True, if sample time instant";
    output Boolean firstTrigger(start=false, fixed=true)
      "Rising edge signals first sample instant";
  equation
    sampleTrigger = sample(startTime, samplePeriod);
    when sampleTrigger then
      firstTrigger = time <= startTime + samplePeriod/2;
    end when;
    annotation (Documentation(info="<html>
<p>
Basic definitions of a discrete block of library
Blocks.Discrete.
The output(s) will only change at events, but are not formally a discrete variable(s) in Modelica.
The input(s) will be sampled, and can thus be continuous variable(s).
</p>

<p>
<strong>Important</strong>: If you connect several discrete blocks you should normally ensure that <strong>samplePeriod (and startTime)
are exactly identical</strong> for all blocks, since otherwise the output from one block will be transformed into a continuous signal
and sampled, which can cause a variable delay of up to one sample period leading to unexpected results.
</p>

<p>
Modelica 3.3 introduced synchronous operators that avoid the need to manually propagate samplePeriod to each block.
</p>
</html>"));
  end DiscreteBlock;
  partial block DiscreteSISO
    "Single Input Single Output discrete control block"

    extends DiscreteBlock;

    Modelica.Blocks.Interfaces.RealInput u "Connector of Real input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has one input and one output signal
which are sampled due to the defined <strong>samplePeriod</strong> parameter.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
  end DiscreteSISO;

  partial block DiscreteMIMO
    "Multiple Input Multiple Output discrete control block"

    extends DiscreteBlock;
    parameter Integer nin=1 "Number of inputs";
    parameter Integer nout=1 "Number of outputs";

    Modelica.Blocks.Interfaces.RealInput u[nin] "Connector of Real input signals" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y[nout] "Connector of Real output signals" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Documentation(info="<html>
<p>
Block has a input and a output signal vector
which are sampled due to the defined <strong>samplePeriod</strong> parameter.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
  end DiscreteMIMO;

  partial block DiscreteMIMOs
    "Multiple Input Multiple Output discrete control block"
    parameter Integer n=1 "Number of inputs (= number of outputs)";
    extends DiscreteBlock;

    Modelica.Blocks.Interfaces.RealInput u[n] "Connector of Real input signals" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "Connector of Real output signals" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Documentation(info="<html>
<p>
Block has a input and a output signal vector
where the signal sizes of the input and output vector are identical.
These signals are sampled due to the defined <strong>samplePeriod</strong> parameter.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));

  end DiscreteMIMOs;
  partial block SVdiscrete "Discrete Single-Variable controller"
    extends DiscreteBlock;

    Discrete.Sampler sampler_s(final samplePeriod=samplePeriod, final startTime=
         startTime) annotation (Placement(transformation(extent={{-100,-10},{-80,
              10}})));
    Discrete.Sampler sampler_m(final samplePeriod=samplePeriod, final startTime=
         startTime) annotation (Placement(transformation(
          origin={0,-90},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealInput u_s
      "Scalar setpoint input signal" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput u_m
      "Scalar measurement input signal" annotation (Placement(
          transformation(
          origin={0,-120},
          extent={{20,-20},{-20,20}},
          rotation=270)));
    Modelica.Blocks.Interfaces.RealOutput y
      "Scalar actuator output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
  equation
    connect(u_s, sampler_s.u) annotation (Line(points={{-120,0},{-102,0}}));
    connect(u_m, sampler_m.u) 
      annotation (Line(points={{0,-120},{0,-111},{0,-102}}));
    annotation (Documentation(info="<html>
<p>
Block has two Real input signals and one
Real output signal
that are sampled due to the defined <strong>samplePeriod</strong> parameter.
The block is designed
to be used as base class for a corresponding controller.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
  end SVdiscrete;

  partial block MVdiscrete "Discrete Multi-Variable controller"
    extends DiscreteBlock;
    parameter Integer nu_s=1 "Number of setpoint inputs";
    parameter Integer nu_m=1 "Number of measurement inputs";
    parameter Integer ny=1 "Number of actuator outputs";
    Discrete.Sampler sampler_s[nu_s](each final samplePeriod=samplePeriod,
        each final startTime=startTime) annotation (Placement(transformation(
            extent={{-90,-10},{-70,10}})));
    Discrete.Sampler sampler_m[nu_m](each final samplePeriod=samplePeriod,
        each final startTime=startTime) annotation (Placement(transformation(
          origin={0,-80},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealInput u_s[nu_s]
      "Setpoint input signals" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput u_m[nu_m]
      "Measurement input signals" annotation (Placement(
          transformation(
          origin={0,-120},
          extent={{20,-20},{-20,20}},
          rotation=270)));
    Modelica.Blocks.Interfaces.RealOutput y[ny]
      "Actuator output signals" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));
  equation
    connect(u_s, sampler_s.u) annotation (Line(points={{-120,0},{-92,0}}));
    connect(u_m, sampler_m.u) 
      annotation (Line(points={{0,-120},{0,-106},{0,-92}}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Text(
              extent={{-100,-10},{-80,-30}},
              textString="u_s",
              textColor={0,0,255})}),         Documentation(info="<html>
<p>
Block has two Real input signal vectors and one
Real output signal vector. The vector signals
are sampled due to the defined <strong>samplePeriod</strong> parameter.
The block is designed
to be used as base class for a corresponding controller.
See the base-class <a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a> for more information.
</p>
</html>"));
  end MVdiscrete;

  partial block BooleanSISO
    "Single Input Single Output control block with signals of type Boolean"

    extends Modelica.Blocks.Icons.BooleanBlock;

  public
    BooleanInput u "Connector of Boolean input signal" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    BooleanOutput y "Connector of Boolean output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Documentation(info="<html>
<p>
Block has one continuous Boolean input and one continuous Boolean output signal.
</p>
</html>"));
  end BooleanSISO;

  partial block BooleanMIMOs
    "Multiple Input Multiple Output continuous control block with same number of inputs and outputs of Boolean type"

    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer n=1 "Number of inputs (= number of outputs)";
    BooleanInput u[n] "Connector of Boolean input signals" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    BooleanOutput y[n] "Connector of Boolean output signals" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has a continuous Boolean input and a continuous Boolean output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
  end BooleanMIMOs;

  partial block MI2BooleanMOs
    "2 Multiple Input / Boolean Multiple Output block with same signal lengths"

    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer n=1 "Dimension of input and output vectors.";
    RealInput u1[n] "Connector 1 of Boolean input signals" annotation (
        Placement(transformation(extent={{-140,40},{-100,80}})));
    RealInput u2[n] "Connector 2 of Boolean input signals" annotation (
        Placement(transformation(extent={{-140,-80},{-100,-40}})));
    BooleanOutput y[n] "Connector of Boolean output signals" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>Block has two Boolean input vectors u1 and u2 and one Boolean output
vector y. All vectors have the same number of elements.</p>
</html>"));
  end MI2BooleanMOs;

  partial block SI2BooleanSO "2 Single Input / Boolean Single Output block"

    extends Modelica.Blocks.Icons.BooleanBlock;
    BooleanInput u1 "Connector 1 of Boolean input signals" annotation (
        Placement(transformation(extent={{-140,40},{-100,80}})));
    BooleanInput u2 "Connector 2 of Boolean input signals" annotation (
        Placement(transformation(extent={{-140,-80},{-100,-40}})));
    BooleanOutput y "Connector of Boolean output signals" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has two Boolean input signals u1 and u2 and one Boolean output signal y.
</p>
</html>"));

  end SI2BooleanSO;

  partial block BooleanSignalSource "Base class for Boolean signal sources"

    extends Modelica.Blocks.Icons.BooleanBlock;
    BooleanOutput y "Connector of Boolean output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-70},{68,-70}}, color={192,192,192}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Basic block for Boolean sources of package Blocks.Sources.
This component has one continuous Boolean output signal y.
</p>
</html>"));

  end BooleanSignalSource;
  partial block IntegerSO "Single Integer Output continuous control block"
    extends Modelica.Blocks.Icons.IntegerBlock;

    IntegerOutput y "Connector of Integer output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has one continuous Integer output signal.
</p>
</html>"));
  end IntegerSO;

  partial block IntegerMO "Multiple Integer Output continuous control block"
    extends Modelica.Blocks.Icons.IntegerBlock;

    parameter Integer nout(min=1) = 1 "Number of outputs";
    IntegerOutput y[nout] "Connector of Integer output signals" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has one continuous Integer output signal vector.
</p>
</html>"));
  end IntegerMO;
  partial block IntegerSignalSource
    "Base class for continuous Integer signal source"
    extends IntegerSO;
    parameter Integer offset=0 "Offset of output signal y";
    parameter SI.Time startTime=0 "Output y = offset for time < startTime";
    annotation (Documentation(info="<html>
<p>
Basic block for Integer sources of package Blocks.Sources.
This component has one continuous Integer output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
  end IntegerSignalSource;

  partial block IntegerSIBooleanSO
    "Integer Input Boolean Output continuous control block"

    extends Modelica.Blocks.Icons.BooleanBlock;
    IntegerInput u "Connector of Integer input signal" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    BooleanOutput y "Connector of Boolean output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has a continuous Integer input and a continuous Boolean output signal.
</p>
</html>"));
  end IntegerSIBooleanSO;

  partial block IntegerMIBooleanMOs
    "Multiple Integer Input Multiple Boolean Output continuous control block with same number of inputs and outputs"

    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer n=1 "Number of inputs (= number of outputs)";
    IntegerInput u[n] "Connector of Integer input signals" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    BooleanOutput y[n] "Connector of Boolean output signals" annotation (
        Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (Documentation(info="<html>
<p>
Block has a continuous Integer input and a continuous Boolean output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
  end IntegerMIBooleanMOs;
  partial block PartialIntegerSISO
    "Partial block with a IntegerInput and an IntegerOutput signal"

    Modelica.Blocks.Interfaces.IntegerInput u "Integer input signal" 
      annotation (Placement(transformation(extent={{-180,-40},{-100,40}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "Integer output signal" 
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          initialScale=0.06), graphics={
          Text(
            extent={{110,-50},{250,-70}},
            textString=DynamicSelect(" ", String(
                  y,
                  minimumLength=1,
                  significantDigits=0))),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            textColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised)}));
  end PartialIntegerSISO;

  partial block PartialIntegerMISO
    "Partial block with an IntegerVectorInput and an IntegerOutput signal"

    parameter Integer nu(min=0) = 0 "Number of input connections" 
      annotation (Dialog(connectorSizing=true), HideResult=true);
    Modelica.Blocks.Interfaces.IntegerVectorInput u[nu]
      "Vector of Integer input signals" 
      annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "Integer output signal" 
      annotation (Placement(transformation(extent={{100,-15},{130,15}})));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.06), graphics={
          Text(
            extent={{110,-50},{250,-70}},
            textString=DynamicSelect(" ", String(
                  y,
                  minimumLength=1,
                  significantDigits=0))),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            textColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,137,0},
            fillColor={255,213,170},
            borderPattern=BorderPattern.Raised,
            fillPattern=FillPattern.Solid)}));
  end PartialIntegerMISO;

  partial block partialBooleanSISO
    "Partial block with 1 input and 1 output Boolean signal"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Ellipse(
            extent={{-71,7},{-85,-7}},
            lineColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{71,7},{85,-7}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Block has one continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanSISO;
  partial block partialBooleanSI2SO
    "Partial block with 2 input and 1 output Boolean signal"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u1 "Connector of first Boolean input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.BooleanInput u2
      "Connector of second Boolean input signal" annotation (Placement(
          transformation(extent={{-140,-100},{-100,-60}})));
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-71,7},{-85,-7}},
            lineColor=DynamicSelect({235,235,235}, if u1 then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if u1 then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-71,-74},{-85,-88}},
            lineColor=DynamicSelect({235,235,235}, if u2 then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if u2 then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{71,7},{85,-7}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Block has two continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanSI2SO;

  partial block partialBooleanSI3SO
    "Partial block with 3 input and 1 output Boolean signal"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u1 "Connector of first Boolean input signal" 
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Blocks.Interfaces.BooleanInput u2
      "Connector of second Boolean input signal" annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.BooleanInput u3 "Connector of third Boolean input signal" 
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-71,74},{-85,88}},
            lineColor=DynamicSelect({235,235,235}, if u1 then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if u1 then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-71,7},{-85,-7}},
            lineColor=DynamicSelect({235,235,235}, if u2 then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if u2 then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-71,-74},{-85,-88}},
            lineColor=DynamicSelect({235,235,235}, if u3 then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if u3 then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{71,7},{85,-7}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>
Block has three continuous Boolean input and one continuous Boolean output signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanSI3SO;

  partial block partialBooleanSI "Partial block with 1 input Boolean signal"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Ellipse(
            extent={{-71,7},{-85,-7}},
            lineColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if u then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Block has one continuous Boolean input signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanSI;

  partial block partialBooleanSO "Partial block with 1 output Boolean signal"

    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Ellipse(
            extent={{71,7},{85,-7}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Block has one continuous Boolean output signal
with a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanSO;

  partial block partialBooleanSource
    "Partial source block (has 1 output Boolean signal and an appropriate default icon)"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-80,88},{-88,66},{-72,66},{-80,88}},
            lineColor={255,0,255},
            fillColor={255,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
          Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}},
            lineColor={255,0,255},
            fillColor={255,0,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{71,7},{85,-7}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Basic block for Boolean sources of package Blocks.Sources.
This component has one continuous Boolean output signal y
and a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanSource;

  partial block partialBooleanThresholdComparison
    "Partial block to compare the Real input u with a threshold and provide the result as 1 Boolean output signal"

    parameter Real threshold=0 "Comparison with respect to threshold";

    Blocks.Interfaces.RealInput u "Connector of Real input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-150,-140},{150,-110}},
            textString="%threshold"),
          Ellipse(
            extent={{71,7},{85,-7}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid), Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            textColor={0,0,255})}), Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Boolean output signal
as well as a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanThresholdComparison;

  partial block partialBooleanComparison
    "Partial block with 2 Real input and 1 Boolean output signal (the result of a comparison of the two Real inputs)"

    Blocks.Interfaces.RealInput u1 "Connector of first Real input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.RealInput u2 "Connector of second Real input signal" 
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Ellipse(
            extent={{73,7},{87,-7}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid),
          Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
          Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
                                                 Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            textColor={0,0,255})}),
        Documentation(info="<html>
<p>
Block has two continuous Real input and one continuous Boolean output signal
as a result of the comparison of the two input signals. The block
has a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

  end partialBooleanComparison;
  partial block partialIntegerBooleanComparison
    "Partial block with 2 Integer input and 1 Boolean output signal (the result of a comparison of the two Integer inputs)"

    IntegerInput u1 "Connector of first Real input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    IntegerInput u2 "Connector of second Real input signal" 
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
  preserveAspectRatio=true,
  grid={2,2}),graphics = {Rectangle(origin={0,0},
  fillColor={210,210,210},
  fillPattern=FillPattern.Solid,
  borderPattern=BorderPattern.Raised,
  extent={{-100,100},{100,-100}}), Ellipse(origin={80,0},
  lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
  fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
  fillPattern=FillPattern.Solid,
  extent={{-7,7},{7,-7}}), Ellipse(origin={42,0},
  lineColor={255,127,0},
  extent={{-10,10},{10,-10}}), Line(origin={-29,-40},
  points={{-71,-40},{71,-40},{71,40}},
  color={255,127,0}), Text(origin={0,130},
  lineColor={0,0,255},
  extent={{-150,20},{150,-20}},
  textString="%name",
  textColor={0,0,255})}),
        Documentation(info="<html><p>
Block has two continuous Integer input and one continuous Boolean output signal as a result of the comparison of the two input signals. The block has a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"  ));

  end partialIntegerBooleanComparison;

  partial block PartialBooleanSISO_small
    "Partial block with a BooleanInput and a BooleanOutput signal and a small block icon"

    Modelica.Blocks.Interfaces.BooleanInput u "Boolean input signal" 
      annotation (Placement(transformation(extent={{-180,-40},{-100,40}})));
    Modelica.Blocks.Interfaces.BooleanOutput y "Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.04), graphics={
          Text(
            extent={{-300,200},{300,120}},
            textString="%name",
            textColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Ellipse(
            extent={{60,10},{80,-10}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}));
  end PartialBooleanSISO_small;

  partial block PartialBooleanMISO
    "Partial block with a BooleanVectorInput and a BooleanOutput signal"

    parameter Integer nu(min=0) = 0 "Number of input connections" 
      annotation (Dialog(connectorSizing=true), HideResult=true);
    Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
      "Vector of Boolean input signals" 
      annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
    Modelica.Blocks.Interfaces.BooleanOutput y "Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-15},{130,15}})));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          initialScale=0.06), graphics={
          Text(
            extent={{-250,170},{250,110}},
            textString="%name",
            textColor={0,0,255}),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Ellipse(
            extent={{60,10},{80,-10}},
            lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
            fillPattern=FillPattern.Solid)}));
  end PartialBooleanMISO;

  partial block PartialConversionBlock
    "Partial block defining the interface for conversion blocks"

    RealInput u "Connector of Real input signal to be converted" annotation (
        Placement(transformation(extent={{-140,-20},{-100,20}})));
    RealOutput y
      "Connector of Real output signal containing input signal u in another unit" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Rectangle(
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-100.0},{100.0,100.0}}),
        Line(
          points={{-90.0,0.0},{30.0,0.0}},
          color={191,0,0}),
        Polygon(
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          points={{90.0,0.0},{30.0,20.0},{30.0,-20.0},{90.0,0.0}}),
        Text(
          textColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString="%name")}), Documentation(info="<html>
<p>
This block defines the interface of a conversion block that
converts from one unit into another one.
</p>

</html>"));

  end PartialConversionBlock;

  partial block PartialNoise "Partial noise generator"
    import generator = Modelica.Math.Random.Generators.Xorshift128plus;
    import Modelica.Math.Random.Utilities.automaticLocalSeed;
    extends Modelica.Blocks.Interfaces.SO;

    // Main dialog menu
    parameter SI.Period samplePeriod(start=0.01)
      "Period for sampling the raw random numbers" 
      annotation(Dialog(enable=enableNoise));

    // Advanced dialog menu: Noise generation
    parameter Boolean enableNoise = globalSeed.enableNoise
      "= true: y = noise, otherwise y = y_off" 
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group="Noise generation"));
    parameter Real y_off = 0.0
      "Sets y = y_off if enableNoise=false (or time<startTime, see below)" 
      annotation(Dialog(tab="Advanced",group="Noise generation"));

    // Advanced dialog menu: Initialization
    parameter Boolean useGlobalSeed = true
      "= true: use global seed, otherwise ignore it" 
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
    parameter Boolean useAutomaticLocalSeed = true
      "= true: use automatic local seed, otherwise use fixedLocalSeed" 
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
    parameter Integer fixedLocalSeed = 1 "Local seed (any Integer number)" 
      annotation(Dialog(tab="Advanced",group = "Initialization",enable=enableNoise and not useAutomaticLocalSeed));
    parameter SI.Time startTime = 0.0
      "Start time for sampling the raw random numbers" 
      annotation(Dialog(tab="Advanced", group="Initialization",enable=enableNoise));
    final parameter Integer localSeed(fixed=false) "The actual localSeed";
  protected
    outer Modelica.Blocks.Noise.GlobalSeed globalSeed
      "Definition of global seed via inner/outer";
    parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
      "The global seed, which is actually used";
    parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise
      "= true, if noise shall be generated, otherwise no noise";

    // Declare state and random number variables
    Integer state[generator.nState] "Internal state of random number generator";
    discrete Real r "Random number according to the desired distribution";
    discrete Real r_raw "Uniform random number in the range (0,1]";

  initial equation
     localSeed = if useAutomaticLocalSeed then automaticLocalSeed(getInstanceName()) else fixedLocalSeed;
     pre(state) = generator.initialState(localSeed, actualGlobalSeed);
     r_raw = generator.random(pre(state));

  equation
    // Draw random number at sample times
    when generateNoise and sample(startTime, samplePeriod) then
      (r_raw, state) = generator.random(pre(state));
    end when;

    // Generate noise if requested
    y = if not generateNoise or time < startTime then y_off else r;

      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Polygon(
            points={{-76,90},{-84,68},{-68,68},{-76,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
          Line(points={{-86,-14},{72,-14}},
                                        color={192,192,192}),
          Polygon(
            points={{94,-14},{72,-6},{72,-22},{94,-14}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(visible = enableNoise,
             points={{-76,-19},{-62,-19},{-62,-3},{-54,-3},{-54,-51},{-46,-51},{-46,
                -29},{-38,-29},{-38,55},{-30,55},{-30,23},{-30,23},{-30,-37},{-20,
                -37},{-20,-19},{-10,-19},{-10,-47},{0,-47},{0,35},{6,35},{6,49},{12,
                49},{12,-7},{22,-7},{22,5},{28,5},{28,-25},{38,-25},{38,47},{48,47},
                {48,13},{56,13},{56,-53},{66,-53}}),
          Text(
            extent={{-150,-110},{150,-150}},
            textString="%samplePeriod s"),
          Line(visible=not enableNoise,
            points={{-76,48},{72,48}}),
          Text(visible=not enableNoise,
            extent={{-75,42},{95,2}},
            textString="%y_off"),
          Text(visible=enableNoise and not useAutomaticLocalSeed,
            extent={{-92,20},{98,-22}},
            textColor={238,46,47},
            textString="%fixedLocalSeed")}),
      Documentation(info="<html>
<p>
Partial base class of noise generators defining the common features
of noise blocks.
</p>
</html>",   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end PartialNoise;

  package Adaptors "Package with adaptors (especially useful for FMUs)"
    extends Modelica.Icons.InterfacesPackage;

    partial model FlowToPotentialAdaptor "Signal adaptor for a connector with flow, 1st derivative of flow, and 2nd derivative of flow as inputs and
  potential, 1st derivative of potential, and 2nd derivative of potential as outputs (especially useful for FMUs)"
      parameter Boolean use_pder=true "Use output for 1st derivative of potential" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_pder2=true "Use output for 2nd derivative of potential (only if 1st derivative is used, too)" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_fder=true "Use input for 1st derivative of flow" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_fder2=true "Use input for 2nd derivative of flow (only if 1st derivative is used, too)" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      Modelica.Blocks.Interfaces.RealOutput p "Output for potential" 
        annotation (Placement(transformation(extent={{20,70},{40,90}})));
      Modelica.Blocks.Interfaces.RealOutput pder if use_pder
        "Optional output for der(potential)" 
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Modelica.Blocks.Interfaces.RealOutput pder2 if (use_pder and use_pder2)
        "Optional output for der2(potential)" 
        annotation (Placement(transformation(extent={{20,10},{40,30}})));
      Modelica.Blocks.Interfaces.RealInput f "Input for flow" 
        annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
      Modelica.Blocks.Interfaces.RealInput fder if use_fder
        "Optional input for der(flow)" 
        annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
      Modelica.Blocks.Interfaces.RealInput fder2 if (use_fder and use_fder2)
        "Optional input for der2(flow)" 
        annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
    protected
      parameter String Name_p="p" "Name of potential variable";
      parameter String Name_pder="der(p)" "Name of 1st derivative of potential variable";
      parameter String Name_pder2="der2(p)" "Name of 2nd derivative of potential variable";
      parameter String Name_f="f" "Name of flow variable";
      parameter String Name_fder="der(f)" "Name of 1st derivative of flow variable";
      parameter String Name_fder2="der2(f)" "Name of 2nd derivative of flow variable";
      Real y "Output signal" annotation(HideResult=true);
      Modelica.Blocks.Interfaces.RealOutput y1 "Optional 1st derivative of output" annotation(HideResult=true);
      Modelica.Blocks.Interfaces.RealOutput y2 "Optional 2nd derivative of output" annotation(HideResult=true);
      Real u "Input signal" annotation(HideResult=true);
      Modelica.Blocks.Interfaces.RealInput u1 "Optional 1st derivative of input" annotation (HideResult=true);
      Modelica.Blocks.Interfaces.RealInput u2 "Optional 2nd derivative of input" annotation (HideResult=true);
    equation
      y = p;
      y1 = if use_pder then der(y) else 0;
      y2 = if (use_pder and use_pder2) then der(y1) else 0;
      connect(y1, pder);
      connect(y2, pder2);
      if use_fder then
        connect(fder, u1);
      else
        u1 = 0;
      end if;
      if (use_fder and use_fder2) then
        connect(fder2, u2);
      else
        u2 = 0;
      end if;
      if (use_fder and use_fder2) then
        u = Functions.state2({f, u1, u2}, time);
      elseif (use_fder and not use_fder2) then
        u = Functions.state1({f, u1}, time);
      else
        u = f;
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
              extent={{-150,150},{150,110}},
              textColor={0,0,255},
              textString="%name"),
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={0,0,127},
                  radius=10),
            Text(
              extent={{-18,90},{18,70}},
              textString="%Name_p"),
            Text(
              extent={{-18,60},{18,40}},
              textString="%Name_pder",
              visible=use_pder),
            Text(
              extent={{-18,30},{18,10}},
              textString="%Name_pder2",
              visible=(use_pder and use_pder2)),
            Text(
              extent={{-18,-70},{18,-90}},
              textString="%Name_f"),
            Text(
              extent={{-18,-40},{18,-60}},
              textString="%Name_fder",
              visible=use_fder),
            Text(
              extent={{-18,-10},{18,-30}},
              textString="%Name_fder2",
              visible=(use_fder and use_fder2))}),
              Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>
Adaptor between a physical connector and a signal representation of the connector signals.
This component is used to provide a pure signal interface around a physical model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
</p>
<p>
This adaptor has flow, optional 1st derivative of flow, and optional 2nd derivative of flow as input and
potential, optional 1st derivative of potential, and optional 2nd derivative of potential as output signals.
</p>
<p>
Note, the input signals must be consistent to each other
(fder=der(f), fder2=der(fder)).
</p>
</html>"));
    end FlowToPotentialAdaptor;

    partial model PotentialToFlowAdaptor "Signal adaptor for a connector with potential, 1st derivative of potential, and 2nd derivative of potential as inputs and
  flow, 1st derivative of flow, and 2nd derivative of flow as outputs (especially useful for FMUs)"
      parameter Boolean use_pder=true "Use input for 1st derivative of potential" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_pder2=true "Use input for 2nd derivative of potential (only if 1st derivative is used, too)" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_fder=true "Use output for 1st derivative of flow" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_fder2=true "Use output for 2nd derivative of flow (only if 1st derivative is used, too)" 
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      Modelica.Blocks.Interfaces.RealInput p "Input for potential" 
        annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
      Modelica.Blocks.Interfaces.RealInput pder if use_pder
        "Optional input for der(potential)" 
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      Modelica.Blocks.Interfaces.RealInput pder2 if (use_pder and use_pder2)
        "Optional input for der2(potential)" 
        annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
      Modelica.Blocks.Interfaces.RealOutput f "Output for flow" 
        annotation (Placement(transformation(extent={{-20,-90},{-40,-70}})));
      Modelica.Blocks.Interfaces.RealOutput fder if use_fder
        "Optional output for der(flow)" 
        annotation (Placement(transformation(extent={{-20,-60},{-40,-40}})));
      Modelica.Blocks.Interfaces.RealOutput fder2 if (use_fder and use_fder2)
        "Optional output for der2(flow)" 
        annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
    protected
      parameter String Name_p="p" "Name of potential variable";
      parameter String Name_pder="der(p)" "Name of 1st derivative of potential variable";
      parameter String Name_pder2="der2(p)" "Name of 2nd derivative of potential variable";
      parameter String Name_f="f" "Name of flow variable";
      parameter String Name_fder="der(f)" "Name of 1st derivative of flow variable";
      parameter String Name_fder2="der2(f)" "Name of 2nd derivative of flow variable";
      Real y "Output signal" annotation(HideResult=true);
      Modelica.Blocks.Interfaces.RealOutput y1 "Optional 1st derivative of output" annotation(HideResult=true);
      Modelica.Blocks.Interfaces.RealOutput y2 "Optional 2nd derivative of output" annotation(HideResult=true);
      Real u "Input signal" annotation(HideResult=true);
      Modelica.Blocks.Interfaces.RealInput u1 "Optional 1st derivative of input" annotation (HideResult=true);
      Modelica.Blocks.Interfaces.RealInput u2 "Optional 2nd derivative of input" annotation (HideResult=true);
    equation
      y = -f;
      y1 = if use_fder then -der(y) else 0;
      y2 = if (use_fder and use_fder2) then -der(y1) else 0;
      connect(y1, fder);
      connect(y2, fder2);
      if use_pder then
        connect(pder, u1);
      else
        u1 = 0;
      end if;
      if (use_pder and use_pder2) then
        connect(pder2, u2);
      else
        u2 = 0;
      end if;
      if (use_pder and use_pder2) then
        u = Functions.state2({p, u1, u2}, time);
      elseif (use_pder and not use_pder2) then
        u = Functions.state1({p, u1}, time);
      else
        u = p;
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
              extent={{-150,150},{150,110}},
              textColor={0,0,255},
              textString="%name"),
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={0,0,127},
                  radius=10),
            Text(
              extent={{-18,90},{18,70}},
              textString="%Name_p"),
            Text(
              extent={{-18,60},{18,40}},
              textString="%Name_pder",
              visible=use_pder),
            Text(
              extent={{-18,30},{18,10}},
              textString="%Name_pder2",
              visible=(use_pder and use_pder2)),
            Text(
              extent={{-18,-70},{18,-90}},
              textString="%Name_f"),
            Text(
              extent={{-18,-40},{18,-60}},
              textString="%Name_fder",
              visible=use_fder),
            Text(
              extent={{-18,-10},{18,-30}},
              textString="%Name_fder2",
              visible=(use_fder and use_fder2))}),
              Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>
Adaptor between a physical connector and a signal representation of the connector signals.
This component is used to provide a pure signal interface around a physical model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
</p>
<p>
This adaptor has potential, optional 1st derivative of potential, and optional 2nd derivative of potential as input and
flow, optional 1st derivative of flow, and optional 2nd derivative of flow as output signals.
</p>
<p>
Note, the input signals must be consistent to each other
(pder=der(p), pder2=der(pder)).
</p>
</html>"));
    end PotentialToFlowAdaptor;

    package Functions "Functions for adaptors"
      extends Modelica.Icons.FunctionsPackage;

      function state1 "Return state (with one derivative)"
        extends Modelica.Icons.Function;
        input Real u[2] "Required values for state and der(s)";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        output Real s;
      algorithm
        s := u[1];
        annotation (derivative(noDerivative=u) = state1der1,
            InlineAfterIndexReduction=true);
      end state1;

      function state1der1 "Return 1st derivative (der of state1)"
        extends Modelica.Icons.Function;
        input Real u[2] "Required values for state and der(s)";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        input Real dummy_der;
        output Real sder1;
      algorithm
        sder1 := u[2];
        annotation (InlineAfterIndexReduction=true);
      end state1der1;

      function state2 "Return state (with two derivatives)"
        extends Modelica.Icons.Function;
        input Real u[3] "Required values for state and der(s)";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        output Real s;
      algorithm
        s := u[1];
        annotation (derivative(noDerivative=u) = state2der1,
            InlineAfterIndexReduction=true);
      end state2;

      function state2der1 "Return 1st derivative (der of state2)"
        extends Modelica.Icons.Function;
        input Real u[3] "Required values for state and der(s)";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        input Real dummy_der;
        output Real sder1;
      algorithm
        sder1 := u[2];
        annotation (derivative(noDerivative=u, order=2) = state2der2,
            InlineAfterIndexReduction=true);
      end state2der1;

      function state2der2 "Return 2nd derivative (der of state2der1)"
        extends Modelica.Icons.Function;
        input Real u[3] "Required values for state and der(s)";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        input Real dummy_der;
        input Real dummy_der2;
        output Real sder2;
      algorithm
        sder2 := u[3];
        annotation (InlineAfterIndexReduction=true);
      end state2der2;
    end Functions;

    annotation (Documentation(info="<html>
<p>
This package contains partial adaptors to implement adaptors in various domains
between a physical connector and a signal representation of the connector signals.
This component is used to provide a pure signal interface around a physical model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
</p>
</html>"));
  end Adaptors;
  annotation (Documentation(info="<html>
<p>
This package contains interface definitions for
<strong>continuous</strong> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</html>", revisions="<html>
<ul>
<li><em>June 28, 2019</em>
       by Thomas Beutlich:<br>
       Removed obsolete blocks.</li>
<li><em>Oct. 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Added several new interfaces.</li>
<li><em>Oct. 24, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal renamed to RealInput. RealOutputSignal renamed to
       output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
       SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
       SignalGenerator renamed to SignalSource. Introduced the following
       new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
       DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
       BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
<li><em>June 30, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
  package TYAdapters "Used to avoid the problem of model differentiation failure"
    extends Modelica.Icons.InterfacesPackage;
    model InputAdapter "Input Signal Adapter: Used to Avoid Model Differentiation Failure Due to Input Signals (Scalar Version)"
      parameter Types.InputHandling inputHandling = "ApproximateDerivatives" "Type of Input Adapter" 
        annotation(Evaluate = true, HideResult = true);
      final parameter Integer ty_type = if inputHandling == "ProvideSignals" then 1 else if inputHandling == "ApproximateDerivatives" then 2 else 3 
        annotation(Evaluate = true, HideResult = true);

      parameter Types.ProvideSignals psType = "InputAndFirstDerivative" "Type of ProvideSignals" 
        annotation(Dialog(group = "ProvideSignals", enable = ty_type == 1), Evaluate = true, HideResult = true);

      parameter Types.ApproxDerivatives adType = "FirstOrderApproximateDerivatives" "Type of ApproximateDerivatives" 
        annotation(Dialog(group = "ApproximateDerivatives", enable = ty_type == 2), Evaluate = true, HideResult = true);
      parameter Real timeConstant = 0.001 "time constant" 
        annotation(Dialog(group = "ApproximateDerivatives", enable = ty_type == 2), Evaluate = true, HideResult = true);

      final parameter Boolean use_fder = (ty_type == 1 and psType == "InputAndFirstDerivative") 
        annotation(Evaluate = true, HideResult = true);
      final parameter Boolean use_fder2 = (ty_type == 1 and psType == "InputAndFirstTwoDerivatives") 
        annotation(Evaluate = true, HideResult = true);

      final parameter Boolean use_ad2 = (ty_type == 2 and adType == "SecondOrderApproximateDerivative") 
        annotation(Evaluate = true, HideResult = true);

      Modelica.Blocks.Interfaces.RealInput u 
        annotation(Placement(transformation(origin = {-222, 0},
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y 
        annotation(Placement(transformation(origin = {212, 0},
        extent = {{-10, -10}, {10, 10}})));

      Modelica.Blocks.Interfaces.RealInput u_der if (use_fder or use_fder2) 
        annotation(Placement(transformation(origin = {-90, -120},
        extent = {{-20, -20}, {20, 20}},
        rotation = 90)));
      Modelica.Blocks.Interfaces.RealInput u_der2 if use_fder2 
        annotation(Placement(transformation(origin = {82, -118},
        extent = {{-20, -20}, {20, 20}},
        rotation = 90)));

      Modelica.Blocks.Continuous.Derivative derivative(T = timeConstant) if ty_type == 2 
        annotation(Placement(transformation(origin = {-134, 0},
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.Derivative derivative2(T = timeConstant) if use_ad2 
        annotation(Placement(transformation(origin = {-38, 0},
        extent = {{-10, -10}, {10, 10}})));

      annotation(Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}},
        preserveAspectRatio = true,
        grid = {2, 2}), graphics = {Rectangle(origin = {0, 0},
        lineColor = {0, 0, 255},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-200, 100}, {200, -100}}), Text(visible = ty_type == 1 and use_fder,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Input and first derivative",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 1 and use_fder2,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Input and first two derivatives",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 2 and not use_ad2,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "First order Approximate Derivative",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 2 and use_ad2,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Second order Approximate Derivative",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 3,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Zeros Derivative",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(origin = {0, 57},
        lineColor = {0, 0, 255},
        extent = {{-198, 40}, {198, -40}},
        textString = "Input Adapter",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(origin = {0, 144},
        lineColor = {0, 0, 255},
        extent = {{-228, 40}, {228, -40}},
        textString = "%name",
        textColor = {0, 0, 255})}),
        Documentation(revisions = "<html><li><p>2025-11-07 Chen,Zhipeng initially implemented</li></p></html>",
        info = "<html>
    <p>The InputAdapter provides three types of adapters for users to choose from to avoid model translation differentiation failure.</p>
    <p>Its categories are controlled by the variable inputHandling of the InputHandling type:</p>
    <p>
    1. <strong>ProvideSignals</strong>: The derivative signal is provided by the user. If the input signal and the derivative signal do not match, the final simulation results may not be accurate.
    </p>
    <p>
    2. <strong>ApproxDerivatives</strong> (default option, and recommended option): The derivative is provided by Modelica.Blocks.Continuous.Derivative through an approximate derivative of the input signal, and the user needs to provide the difference parameter T (default value is 0.001).
    </p>
    <p>
    3. <strong>ZerosDerivatives</strong>: The derivative value is always 0, which is only suitable for piecewise constant cases. If the input signal is sampled from a continuous signal, the final simulation results may not be accurate.
    </p>

    <p>
    When the value of inputHandling is <strong>ProvideSignals</strong>, there are the following three options for users to choose from in the external derivative settings:
    </p>
    <p>
    1.1. <strong>InputOnly</strong>: consistent with the effect of not using this module.
    </p>
    <p>
    1.2. <strong>InputAndFirstDerivative</strong> (default option): an additional first-order derivative needs to be provided.
    </p>
    <p>
    1.3. <strong>InputAndFirstTwoDerivatives</strong>: an additional first-order derivative and second-order derivative need to be provided.
    </p>

    <p>
    When the value of inputHandling is <strong>ApproximateDerivative</strong>, there are the following two options for users to choose from in the approximate derivative settings:
    </p>
    <p>
    2.1. <strong>FirstOrderApproximateDerivative</strong> (default option): The derivative is approximated by Modelica.Blocks.Continuous.Derivative, and the user needs to provide the difference parameter T (default value is 0.001).
    </p>
    <p>
    2.2. <strong>SecondOrderApproximateDerivative</strong>: This is equivalent to two first-order approximate derivatives connected in series.
    </p>
    <p>
    And the user needs to set the value of the timeConstant (default value 0.001) to adapt to models with different time characteristics.
    </p>

    <p>
    When the value of inputHandling is <strong>ZeroDerivative</strong>, no additional settings are required.
    </p>
    </html>"    ));
    equation
      if ty_type == 1 then
        if use_fder2 then
          y = Functions.fstate2(u, u_der, u_der2, 0);
        elseif use_fder then
          y = Functions.fstate1(u, u_der, 0);
        else
          y = u;
        end if;
      elseif ty_type == 2 then
        if use_ad2 then
          y = Functions.fstate2(u, derivative.y, derivative2.y, 0);
        else
          y = Functions.fstate1(u, derivative.y, 0);
        end if;
      else
        y = Functions.fstate0(u, 0);
      end if;

      connect(derivative.u, u) 
        annotation(Line(origin = {-91, -16},
        points = {{-55, 16}, {-131, 16}},
        color = {0, 0, 127}));
      connect(derivative.y, derivative2.u) 
        annotation(Line(origin = {-19, 6},
        points = {{-104, -6}, {-31, -6}},
        color = {0, 0, 127}));

    end InputAdapter;
    model InputAdapter1D "Input Signal Adapter: Used to Avoid Model Differentiation Failure Due to Input Signals (Vector Version)"
      parameter Integer m(min = 1) = 3 
        annotation(Evaluate = true, HideResult = true);

      parameter Types.InputHandling inputHandling = "ApproximateDerivatives" "Type of Input Adapter" 
        annotation(Evaluate = true, HideResult = true);
      final parameter Integer ty_type = if inputHandling == "ProvideSignals" then 1 else if inputHandling == "ApproximateDerivatives" then 2 else 3 
        annotation(Evaluate = true, HideResult = true);

      parameter Types.ProvideSignals psType = "InputAndFirstDerivative" "Type of ProvideSignals" 
        annotation(Dialog(group = "ProvideSignals", enable = ty_type == 1), Evaluate = true, HideResult = true);

      parameter Types.ApproxDerivatives adType = "FirstOrderApproximateDerivatives" "Type of ApproximateDerivatives" 
        annotation(Dialog(group = "ApproximateDerivatives", enable = ty_type == 2), Evaluate = true, HideResult = true);
      parameter Real timeConstant = 0.001 "time constant" 
        annotation(Dialog(group = "ApproximateDerivatives", enable = ty_type == 2), Evaluate = true, HideResult = true);

      final parameter Boolean use_fder = (ty_type == 1 and psType == "InputAndFirstDerivative") 
        annotation(Evaluate = true, HideResult = true);
      final parameter Boolean use_fder2 = (ty_type == 1 and psType == "InputAndFirstTwoDerivatives") 
        annotation(Evaluate = true, HideResult = true);

      final parameter Boolean use_ad2 = (ty_type == 2 and adType == "SecondOrderApproximateDerivative") 
        annotation(Evaluate = true, HideResult = true);

      Modelica.Blocks.Interfaces.RealVectorInput[m] u 
        annotation(Placement(transformation(origin = {-218, 0},
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealVectorOutput[m] y 
        annotation(Placement(transformation(origin = {208, 0},
        extent = {{-10, -10}, {10, 10}})));

      Modelica.Blocks.Interfaces.RealVectorInput[m] u_der if (use_fder or use_fder2) 
        annotation(Placement(transformation(origin = {-104, -120},
        extent = {{-20, -20}, {20, 20}},
        rotation = 90)));
      Modelica.Blocks.Interfaces.RealVectorInput[m] u_der2 if use_fder2 
        annotation(Placement(transformation(origin = {100, -120},
        extent = {{-20, -20}, {20, 20}},
        rotation = 90)));

      Modelica.Blocks.Continuous.Derivative[m] derivative(T = timeConstant) if ty_type == 2 
        annotation(Placement(transformation(origin = {-96, 0},
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.Derivative[m] derivative2(T = timeConstant) if use_ad2 
        annotation(Placement(transformation(origin = {-2, 0},
        extent = {{-10, -10}, {10, 10}})));

      annotation(Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}},
        preserveAspectRatio = true,
        grid = {2, 2}), graphics = {Rectangle(origin = {0, 0},
        lineColor = {0, 0, 255},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-200, 100}, {200, -100}}), Text(visible = ty_type == 1 and use_fder,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Input and first derivative",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 1 and use_fder2,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Input and first two derivatives",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 2 and not use_ad2,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "First order Approximate Derivative",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 2 and use_ad2,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Second order Approximate Derivative",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(visible = ty_type == 3,
        origin = {0, -60},
        lineColor = {0, 0, 255},
        extent = {{-226, 28}, {226, -28}},
        textString = "Zeros Derivatives",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(origin = {0, 57},
        lineColor = {0, 0, 255},
        extent = {{-198, 40}, {198, -40}},
        textString = "Input Adapter",
        textStyle = {TextStyle.None},
        textColor = {0, 0, 255}), Text(origin = {0, 144},
        lineColor = {0, 0, 255},
        extent = {{-228, 40}, {228, -40}},
        textString = "%name",
        textColor = {0, 0, 255}), Text(origin = {0, -157},
        extent = {{200, -37}, {-200, 37}},
        textString = "m=%m")}),
        Documentation(revisions = "<html><li><p>2025-11-07 Chen,Zhipeng initially implemented</li></p></html>",
        info = "<html>
    <p>The InputAdapter provides three types of adapters for users to choose from to avoid model translation differentiation failure.</p>
    <p>Its categories are controlled by the variable inputHandling of the InputHandling type:</p>
    <p>
    1. <strong>ProvideSignals</strong>: The derivative signal is provided by the user. If the input signal and the derivative signal do not match, the final simulation results may not be accurate.
    </p>
    <p>
    2. <strong>ApproxDerivatives</strong> (default option, and recommended option): The derivative is provided by Modelica.Blocks.Continuous.Derivative through an approximate derivative of the input signal, and the user needs to provide the difference parameter T (default value is 0.001).
    </p>
    <p>
    3. <strong>ZerosDerivatives</strong>: The derivative value is always 0, which is only suitable for piecewise constant cases. If the input signal is sampled from a continuous signal, the final simulation results may not be accurate.
    </p>

    <p>
    When the value of inputHandling is <strong>ProvideSignals</strong>, there are the following three options for users to choose from in the external derivative settings:
    </p>
    <p>
    1.1. <strong>InputOnly</strong>: consistent with the effect of not using this module.
    </p>
    <p>
    1.2. <strong>InputAndFirstDerivative</strong> (default option): an additional first-order derivative needs to be provided.
    </p>
    <p>
    1.3. <strong>InputAndFirstTwoDerivatives</strong>: an additional first-order derivative and second-order derivative need to be provided.
    </p>

    <p>
    When the value of inputHandling is <strong>ApproximateDerivative</strong>, there are the following two options for users to choose from in the approximate derivative settings:
    </p>
    <p>
    2.1. <strong>FirstOrderApproximateDerivative</strong> (default option): The derivative is approximated by Modelica.Blocks.Continuous.Derivative, and the user needs to provide the difference parameter T (default value is 0.001).
    </p>
    <p>
    2.2. <strong>SecondOrderApproximateDerivative</strong>: This is equivalent to two first-order approximate derivatives connected in series.
    </p>
    <p>
    And the user needs to set the value of the timeConstant (default value 0.001) to adapt to models with different time characteristics.
    </p>

    <p>
    When the value of inputHandling is <strong>ZeroDerivative</strong>, no additional settings are required.
    </p>
    </html>"    ));
    equation
      if ty_type == 1 then
        if use_fder2 then
          y = Functions.fstate2(u, u_der, u_der2, 0);
        elseif use_fder then
          y = Functions.fstate1(u, u_der, 0);
        else
          y = u;
        end if;
      elseif ty_type == 2 then
        if use_ad2 then
          y = Functions.fstate2(u, derivative.y, derivative2.y, 0);
        else
          y = Functions.fstate1(u, derivative.y, 0);
        end if;
      else
        y = Functions.fstate0(u, 0);
      end if;

      connect(derivative.u, u) 
        annotation(Line(origin = {-91, -16},
        points = {{-17, 16}, {-127, 16}},
        color = {0, 0, 127}));
      connect(derivative.y, derivative2.u) 
        annotation(Line(origin = {-19, 6},
        points = {{-66, -6}, {5, -6}},
        color = {0, 0, 127}));

    end InputAdapter1D;

    package Examples "Examples of input signal adapters"
      extends Modelica.Icons.ExamplesPackage;

      model FixDerIssue1 "Using Input Signal Adapters to Solve Differentiation Failure Problems (Scalar Version)"
        Modelica.Blocks.Interfaces.RealInput u 
          annotation(Placement(transformation(origin = {-120, 0},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent 
          annotation(Placement(transformation(origin = {-12, -42},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Inductor inductor(L=1) 
          annotation(Placement(transformation(origin = {36, -42},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor(R=1) 
          annotation(Placement(transformation(origin = {84, -42},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Ground ground 
          annotation(Placement(transformation(origin = {-42, -104},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
          annotation(Placement(transformation(origin = {84, -16},
          extent = {{-10, 10}, {10, -10}})));
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation(Placement(transformation(origin = {110, 0},
          extent = {{-10, -10}, {10, 10}})));
        InputAdapter inputAdapter1 
          annotation(Placement(transformation(origin = {-54, 0},
          extent = {{-20, -20}, {20, 20}})));
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2})), Documentation(info = "<html><p>
This model provides an example of using InputAdapter to avoid differentiation failure in model translation:
</p>
<p>
1. This example is derived from a real engineering model that has been extremely simplified.
</p>
<p>
2. If the InputAdapter module is removed and the input u is directly connected to SignalCurrent, the differentiation failure in translation will be reproduced.
</p>
<p>
3. The current type of InputAdapter used is: Approximate Derivatives.
</p>
</html>"    ));
      equation
        connect(signalCurrent.n, inductor.p) 
          annotation(Line(origin = {8, -42},
          points = {{-10, 0}, {18, 0}},
          color = {0, 0, 255}));
        connect(inductor.n, resistor.p) 
          annotation(Line(origin = {60, -42},
          points = {{-14, 0}, {14, 0}},
          color = {0, 0, 255}));
        connect(ground.p, signalCurrent.p) 
          annotation(Line(origin = {-38, -61},
          points = {{-4, -33}, {-4, 19}, {16, 19}},
          color = {0, 0, 255}));
        connect(resistor.n, ground.p) 
          annotation(Line(origin = {33, -61},
          points = {{61, 19}, {79, 19}, {79, -19}, {-75, -19}, {-75, -33}},
          color = {0, 0, 255}), __MWORKS(BlockSystem(NamedSignal)));
        connect(y, voltageSensor.v) 
          annotation(Line(origin = {110, -2},
          points = {{0, 2}, {-26, 2}, {-26, -3}},
          color = {0, 0, 127}));
        connect(voltageSensor.p, resistor.p) 
          annotation(Line(origin = {68, -8},
          points = {{6, -8}, {-8, -8}, {-8, -34}, {6, -34}},
          color = {0, 0, 255}));
        connect(voltageSensor.n, resistor.n) 
          annotation(Line(origin = {96, -21},
          points = {{-2, 5}, {1, 5}, {1, -21}, {-2, -21}},
          color = {0, 0, 255}));
        connect(u, inputAdapter1.u) 
          annotation(Line(origin = {-98, 0},
          points = {{-22, 0}, {21.8, 0}},
          color = {0, 0, 127}));
        connect(inputAdapter1.y, signalCurrent.i) 
          annotation(Line(origin = {-22, -15},
          points = {{-10.8, 15}, {10, 15}, {10, -15}},
          color = {0, 0, 127}));
      end FixDerIssue1;

      model FixDerIssue1_1D "Using Input Signal Adapters to Solve Differentiation Failure Problems (Vector Version)"
        parameter Integer m(min = 1) = 3 
          annotation(Evaluate = true, HideResult = true);
        Modelica.Blocks.Interfaces.RealVectorInput[m] u 
          annotation(Placement(transformation(origin = {-120, 6},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(m = m) 
          annotation(Placement(transformation(origin = {-6, -43},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Resistor resistor(m = m,R=fill(1, m)) 
          annotation(Placement(transformation(origin = {80, -43},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Inductor inductor(m = m,L=fill(1, m)) 
          annotation(Placement(transformation(origin = {37, -43},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Ground ground 
          annotation(Placement(transformation(origin = {-34, -135},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Star star(m = m) 
          annotation(Placement(transformation(origin = {-34, -105},
          extent = {{-10, -10}, {10, 10}},
          rotation = 270)));
        Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m = m) 
          annotation(Placement(transformation(origin = {80, -18},
          extent = {{-10, 10}, {10, -10}})));
        Modelica.Blocks.Interfaces.RealVectorOutput[m] y 
          annotation(Placement(transformation(origin = {120, 6},
          extent = {{-20, -20}, {20, 20}})));
        InputAdapter1D inputAdapter1D(m = m) 
          annotation(Placement(transformation(origin = {-62, 6},
          extent = {{-20, -20}, {20, 20}})));
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2})), Documentation(info = "<html><p>
This model provides an example of using InputAdapter to avoid differentiation failure in model translation:
</p>
<p>
1. This example is derived from a real engineering model that has been extremely simplified.
</p>
<p>
2. If the InputAdapter module is removed and the input u is directly connected to SignalCurrent, the differentiation failure in translation will be reproduced.
</p>
<p>
3. The current type of InputAdapter used is: Approximate Derivatives.
</p>
</html>"    ));
      equation
        connect(signalCurrent.plug_n, inductor.plug_p) 
          annotation(Line(origin = {16, -43},
          points = {{-12, 0}, {11, 0}},
          color = {0, 0, 255}));
        connect(resistor.plug_p, inductor.plug_n) 
          annotation(Line(origin = {59, -43},
          points = {{11, 0}, {-12, 0}},
          color = {0, 0, 255}));
        connect(ground.p, star.pin_n) 
          annotation(Line(origin = {-33, -120},
          points = {{-1, -5}, {-1, 5}},
          color = {0, 0, 255}));
        connect(star.plug_p, signalCurrent.plug_p) 
          annotation(Line(origin = {-26, -53},
          points = {{-8, -42}, {-8, 10}, {10, 10}},
          color = {0, 0, 255}));
        connect(resistor.plug_n, star.plug_p) 
          annotation(Line(origin = {32, -53},
          points = {{58, 10}, {68, 10}, {68, -24}, {-66, -24}, {-66, -42}},
          color = {0, 0, 255}));
        connect(voltageSensor.plug_n, resistor.plug_n) 
          annotation(Line(origin = {91, -18},
          points = {{-1, 0}, {2, 0}, {2, -25}, {-1, -25}},
          color = {0, 0, 255}));
        connect(voltageSensor.plug_p, inductor.plug_n) 
          annotation(Line(origin = {58, -18},
          points = {{12, 0}, {0, 0}, {0, -25}, {-11, -25}},
          color = {0, 0, 255}));
        connect(y, voltageSensor.v) 
          annotation(Line(origin = {105, 16},
          points = {{15, -10}, {-25, -10}, {-25, -23}},
          color = {0, 0, 127}));
        connect(u, inputAdapter1D.u) 
          annotation(Line(origin = {-102, 6},
          points = {{-18, 0}, {18.2, 0}},
          color = {0, 0, 127}));
        connect(inputAdapter1D.y, signalCurrent.i) 
          annotation(Line(origin = {-24, -12},
          points = {{-17.2, 18}, {18, 18}, {18, -19}},
          color = {0, 0, 127}));
      end FixDerIssue1_1D;

      model FixDerIssue2 "Using Input Signal Adapters to Solve Differentiation Failure Problems (Scalar Version)"
        Modelica.Blocks.Interfaces.RealInput u 
          annotation(Placement(transformation(origin = {-120, 50},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent 
          annotation(Placement(transformation(origin = {-32, -36},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Inductor inductor(L=1) 
          annotation(Placement(transformation(origin = {16, -36},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor(R=1) 
          annotation(Placement(transformation(origin = {64, -36},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Ground ground 
          annotation(Placement(transformation(origin = {-62, -98},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Blocks.Interfaces.RealInput u_der 
          annotation(Placement(transformation(origin = {-120, -46},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
          annotation(Placement(transformation(origin = {70, -8},
          extent = {{-10, 10}, {10, -10}})));
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation(Placement(transformation(origin = {110, 4},
          extent = {{-10, -10}, {10, 10}})));
        InputAdapter inputAdapter(inputHandling = "ProvideSignals") 
          annotation(Placement(transformation(origin = {-62, 50},
          extent = {{-20, -20}, {20, 20}})));
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2})), Documentation(info = "<html><p>
This model provides an example of using InputAdapter to avoid differentiation failure in model translation:
</p>
<p>
1. This example is derived from a real engineering model that has been extremely simplified.
</p>
<p>
2. If the InputAdapter module is removed and the input u is directly connected to SignalCurrent, the differentiation failure in translation will be reproduced.
</p>
<p>
3. The current type of InputAdapter used is: ProvideSignals.
</p>
</html>"    ));
      equation
        connect(signalCurrent.n, inductor.p) 
          annotation(Line(origin = {-12, -36},
          points = {{-10, 0}, {18, 0}},
          color = {0, 0, 255}));
        connect(inductor.n, resistor.p) 
          annotation(Line(origin = {42, 16},
          points = {{-16, -52}, {12, -52}},
          color = {0, 0, 255}));
        connect(ground.p, signalCurrent.p) 
          annotation(Line(origin = {-58, -55},
          points = {{-4, -33}, {-4, 19}, {16, 19}},
          color = {0, 0, 255}));
        connect(resistor.n, ground.p) 
          annotation(Line(origin = {15, -3},
          points = {{59, -33}, {64, -33}, {64, -85}, {-77, -85}},
          color = {0, 0, 255}), __MWORKS(BlockSystem(NamedSignal)));
        connect(y, voltageSensor.v) 
          annotation(Line(origin = {156, 50},
          points = {{-46, -46}, {-86, -46}, {-86, -47}},
          color = {0, 0, 127}));
        connect(voltageSensor.p, resistor.p) 
          annotation(Line(origin = {33, 34},
          points = {{27, -42}, {7, -42}, {7, -70}, {21, -70}},
          color = {0, 0, 255}));
        connect(voltageSensor.n, resistor.n) 
          annotation(Line(origin = {61, 21},
          points = {{19, -29}, {24, -29}, {24, -57}, {13, -57}},
          color = {0, 0, 255}));
        connect(u, inputAdapter.u) 
          annotation(Line(origin = {-98, 50},
          points = {{-22, 0}, {13.8, 0}},
          color = {0, 0, 127}));
        connect(u_der, inputAdapter.u_der) 
          annotation(Line(origin = {-91, -4},
          points = {{-29, -42}, {20, -42}, {20, 42}},
          color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
        connect(inputAdapter.y, signalCurrent.i) 
          annotation(Line(origin = {-36, 13},
          points = {{-4.8, 37}, {4, 37}, {4, -37}},
          color = {0, 0, 127}));
      end FixDerIssue2;

      model FixDerIssue2_1D "Using Input Signal Adapters to Solve Differentiation Failure Problems (Vector Version)"
        parameter Integer m(min = 1) = 3 
          annotation(Evaluate = true, HideResult = true);
        Modelica.Blocks.Interfaces.RealVectorInput[m] u 
          annotation(Placement(transformation(origin = {-120, 48},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(m = m) 
          annotation(Placement(transformation(origin = {-18, -38},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Resistor resistor(m = m,R=fill(1, m)) 
          annotation(Placement(transformation(origin = {68, -38},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Inductor inductor(m = m,L=fill(1, m)) 
          annotation(Placement(transformation(origin = {25, -38},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Ground ground 
          annotation(Placement(transformation(origin = {-47, -138},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Star star(m = m) 
          annotation(Placement(transformation(origin = {-47, -104},
          extent = {{-10, -10}, {10, 10}},
          rotation = 270)));
        Modelica.Blocks.Interfaces.RealVectorInput[m] u_der 
          annotation(Placement(transformation(origin = {-120, -32},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m = m) 
          annotation(Placement(transformation(origin = {60, -6},
          extent = {{-10, 10}, {10, -10}})));
        Modelica.Blocks.Interfaces.RealVectorOutput[m] y 
          annotation(Placement(transformation(origin = {120, 14},
          extent = {{-20, -20}, {20, 20}})));
        InputAdapter1D inputAdapter1D(inputHandling = "ProvideSignals", psType = "InputAndFirstDerivative", m = m) 
          annotation(Placement(transformation(origin = {-68, 48},
          extent = {{-20, -20}, {20, 20}})));
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2})), Documentation(info = "<html><p>
This model provides an example of using InputAdapter to avoid differentiation failure in model translation:
</p>
<p>
1. This example is derived from a real engineering model that has been extremely simplified.
</p>
<p>
2. If the InputAdapter module is removed and the input u is directly connected to SignalCurrent, the differentiation failure in translation will be reproduced.
</p>
<p>
3. The current type of InputAdapter used is: ProvideSignals.
</p>
</html>"    ));
      equation
        connect(signalCurrent.plug_n, inductor.plug_p) 
          annotation(Line(origin = {4, -38},
          points = {{-12, 0}, {11, 0}},
          color = {0, 0, 255}));
        connect(resistor.plug_p, inductor.plug_n) 
          annotation(Line(origin = {47, -38},
          points = {{11, 0}, {-12, 0}},
          color = {0, 0, 255}));
        connect(ground.p, star.pin_n) 
          annotation(Line(origin = {-132, -115},
          points = {{85, -13}, {85, 1}},
          color = {0, 0, 255}));
        connect(star.plug_p, signalCurrent.plug_p) 
          annotation(Line(origin = {-124, -48},
          points = {{77, -46}, {77, 10}, {96, 10}},
          color = {0, 0, 255}));
        connect(resistor.plug_n, star.plug_p) 
          annotation(Line(origin = {-66, -48},
          points = {{144, 10}, {147, 10}, {147, -28}, {19, -28}, {19, -46}},
          color = {0, 0, 255}));
        connect(voltageSensor.plug_n, resistor.plug_n) 
          annotation(Line(origin = {73, 30},
          points = {{-3, -36}, {8, -36}, {8, -68}, {5, -68}},
          color = {0, 0, 255}));
        connect(voltageSensor.plug_p, inductor.plug_n) 
          annotation(Line(origin = {40, 30},
          points = {{10, -36}, {2, -36}, {2, -68}, {-5, -68}},
          color = {0, 0, 255}));
        connect(y, voltageSensor.v) 
          annotation(Line(origin = {111, 64},
          points = {{9, -50}, {-51, -50}, {-51, -59}},
          color = {0, 0, 127}));
        connect(u, inputAdapter1D.u) 
          annotation(Line(origin = {-105, 48},
          points = {{-15, 0}, {15.2, 0}},
          color = {0, 0, 127}));
        connect(inputAdapter1D.y, signalCurrent.i) 
          annotation(Line(origin = {-33, 11},
          points = {{-14.2, 37}, {15, 37}, {15, -37}},
          color = {0, 0, 127}));
        connect(u_der, inputAdapter1D.u_der) 
          annotation(Line(origin = {-99, 2},
          points = {{-21, -34}, {20.6, -34}, {20.6, 34}},
          color = {0, 0, 127}));
      end FixDerIssue2_1D;

      model FixDerIssue3 "Using Input Signal Adapters to Solve Differentiation Failure Problems (Scalar Version)"
        Modelica.Blocks.Interfaces.RealInput u 
          annotation(Placement(transformation(origin = {-120, 4},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent 
          annotation(Placement(transformation(origin = {-14, -44},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Inductor inductor(L=1) 
          annotation(Placement(transformation(origin = {34, -44},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor(R=1) 
          annotation(Placement(transformation(origin = {82, -44},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Ground ground 
          annotation(Placement(transformation(origin = {-44, -106},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
          annotation(Placement(transformation(origin = {79, -16},
          extent = {{-10, 10}, {10, -10}})));
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation(Placement(transformation(origin = {110, 4},
          extent = {{-10, -10}, {10, 10}})));
        InputAdapter inputAdapter(inputHandling = "ZerosDerivatives") 
          annotation(Placement(transformation(origin = {-62, 4},
          extent = {{-20, -20}, {20, 20}})));
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2})), Documentation(info = "<html><p>
This model provides an example of using InputAdapter to avoid differentiation failure in model translation:
</p>
<p>
1. This example is derived from a real engineering model that has been extremely simplified.
</p>
<p>
2. If the InputAdapter module is removed and the input u is directly connected to SignalCurrent, the differentiation failure in translation will be reproduced.
</p>
<p>
3. The current type of InputAdapter used is: ZerosDerivatives.
</p>
</html>"    ));
      equation
        connect(signalCurrent.n, inductor.p) 
          annotation(Line(origin = {6, -44},
          points = {{-10, 0}, {18, 0}},
          color = {0, 0, 255}));
        connect(inductor.n, resistor.p) 
          annotation(Line(origin = {58, -44},
          points = {{-14, 0}, {14, 0}},
          color = {0, 0, 255}));
        connect(ground.p, signalCurrent.p) 
          annotation(Line(origin = {-40, -63},
          points = {{-4, -33}, {-4, 19}, {16, 19}},
          color = {0, 0, 255}));
        connect(resistor.n, ground.p) 
          annotation(Line(origin = {31, -63},
          points = {{61, 19}, {79, 19}, {79, -19}, {-75, -19}, {-75, -33}},
          color = {0, 0, 255}), __MWORKS(BlockSystem(NamedSignal)));
        connect(y, voltageSensor.v) 
          annotation(Line(origin = {105, -8},
          points = {{34, 16}, {-26, 16}, {-26, 3}},
          color = {0, 0, 127}));
        connect(voltageSensor.p, resistor.p) 
          annotation(Line(origin = {48, -14},
          points = {{21, -2}, {18, -2}, {18, -30}, {24, -30}},
          color = {0, 0, 255}));
        connect(voltageSensor.n, resistor.n) 
          annotation(Line(origin = {76, -27},
          points = {{13, 11}, {26, 11}, {26, -17}, {16, -17}},
          color = {0, 0, 255}));
        connect(u, inputAdapter.u) 
          annotation(Line(origin = {-102, 4},
          points = {{-18, 0}, {17.8, 0}},
          color = {0, 0, 127}));
        connect(inputAdapter.y, signalCurrent.i) 
          annotation(Line(origin = {-27, -14},
          points = {{-13.8, 18}, {13, 18}, {13, -18}},
          color = {0, 0, 127}));
      end FixDerIssue3;

      model FixDerIssue3_1D "Using Input Signal Adapters to Solve Differentiation Failure Problems (Vector Version)"
        parameter Integer m(min = 1) = 3 
          annotation(Evaluate = true, HideResult = true);
        Modelica.Blocks.Interfaces.RealVectorInput[m] u 
          annotation(Placement(transformation(origin = {-120, 6},
          extent = {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(m = m) 
          annotation(Placement(transformation(origin = {-6, -38},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Resistor resistor(m = m,R=fill(1, m)) 
          annotation(Placement(transformation(origin = {80, -38},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Inductor inductor(m = m,L=fill(1, m)) 
          annotation(Placement(transformation(origin = {37, -38},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Analog.Basic.Ground ground 
          annotation(Placement(transformation(origin = {-27, -138},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Electrical.Polyphase.Basic.Star star(m = m) 
          annotation(Placement(transformation(origin = {-27, -104},
          extent = {{-10, -10}, {10, 10}},
          rotation = 270)));
        Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m = m) 
          annotation(Placement(transformation(origin = {70, -14},
          extent = {{-10, 10}, {10, -10}})));
        Modelica.Blocks.Interfaces.RealVectorOutput[m] y 
          annotation(Placement(transformation(origin = {120, 6},
          extent = {{-20, -20}, {20, 20}})));
        InputAdapter1D inputAdapter1D(m = m, inputHandling = "ZerosDerivatives") 
          annotation(Placement(transformation(origin = {-66, 6},
          extent = {{-20, -20}, {20, 20}})));
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2})), Documentation(info = "<html><p>
This model provides an example of using InputAdapter to avoid differentiation failure in model translation:
</p>
<p>
1. This example is derived from a real engineering model that has been extremely simplified.
</p>
<p>
2. If the InputAdapter module is removed and the input u is directly connected to SignalCurrent, the differentiation failure in translation will be reproduced.
</p>
<p>
3. The current type of InputAdapter used is: Approximate Derivatives.
</p>
</html>"    ));
      equation
        connect(signalCurrent.plug_n, inductor.plug_p) 
          annotation(Line(origin = {16, -38},
          points = {{-12, 0}, {11, 0}},
          color = {0, 0, 255}));
        connect(resistor.plug_p, inductor.plug_n) 
          annotation(Line(origin = {59, -38},
          points = {{11, 0}, {-12, 0}},
          color = {0, 0, 255}));
        connect(ground.p, star.pin_n) 
          annotation(Line(origin = {-77, -119},
          points = {{50, -9}, {50, 5}},
          color = {0, 0, 255}));
        connect(star.plug_p, signalCurrent.plug_p) 
          annotation(Line(origin = {-72, -56},
          points = {{45, -38}, {45, 18}, {56, 18}},
          color = {0, 0, 255}));
        connect(resistor.plug_n, star.plug_p) 
          annotation(Line(origin = {-14, -56},
          points = {{104, 18}, {107, 18}, {107, -24}, {-13, -24}, {-13, -38}},
          color = {0, 0, 255}));
        connect(voltageSensor.plug_n, resistor.plug_n) 
          annotation(Line(origin = {53, -10},
          points = {{27, -4}, {40, -4}, {40, -28}, {37, -28}},
          color = {0, 0, 255}));
        connect(voltageSensor.plug_p, inductor.plug_n) 
          annotation(Line(origin = {20, -10},
          points = {{40, -4}, {34, -4}, {34, -28}, {27, -28}},
          color = {0, 0, 255}), __MWORKS(BlockSystem(NamedSignal)));
        connect(y, voltageSensor.v) 
          annotation(Line(origin = {95, 24},
          points = {{25, -18}, {-25, -18}, {-25, -27}},
          color = {0, 0, 127}));
        connect(u, inputAdapter1D.u) 
          annotation(Line(origin = {-104, 6},
          points = {{-16, 0}, {16.2, 0}},
          color = {0, 0, 127}));
        connect(inputAdapter1D.y, signalCurrent.i) 
          annotation(Line(origin = {-26, -10},
          points = {{-19.2, 16}, {20, 16}, {20, -16}},
          color = {0, 0, 127}));
      end FixDerIssue3_1D;

      model UseFixDerIssue1 "Examples of Using InputAdapter of the Approximate Derivatives Type"
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2}), graphics = {Text(origin = {-26, 60},
          lineColor = {0, 0, 0},
          extent = {{-37, -10}, {37, 10}},
          textString = "For differentiation of continuous signals, approximate derivatives can be used.",
          fontSize = 14,
          textStyle = {TextStyle.None},
          textColor = {0, 0, 0},
          horizontalAlignment = TextAlignment.Left)}));
        Modelica.Blocks.Sources.Sine sine(f=1) 
          annotation(Placement(transformation(origin = {-145, 0},
          extent = {{-17, -17}, {17, 17}})));
        FixDerIssue1 FixDerIssue1_1 
          annotation(Placement(transformation(origin = {-26, 0},
          extent = {{-37, -20}, {37, 20}})));
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation(Placement(transformation(origin = {110, 0},
          extent = {{-10, -10}, {10, 10}})));
      equation
        connect(sine.y, FixDerIssue1_1.u) 
          annotation(Line(origin = {-101, 55},
          points = {{-25.3, -55}, {30.6, -55}},
          color = {0, 0, 127}));
        connect(FixDerIssue1_1.y, y) 
          annotation(Line(origin = {27, 55},
          points = {{-12.3, -55}, {83, -55}},
          color = {0, 0, 127}));
      end UseFixDerIssue1;

      model UseFixDerIssue2 "Examples of Using InputAdapter of the ProvideSignals Type"
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2}), graphics = {Text(origin = {-16, 48},
          lineColor = {0, 0, 0},
          extent = {{-48, -10}, {48, 10}},
          textString = "For differentiation of continuous signals, ProvideSignals can be used.",
          fontSize = 14,
          textStyle = {TextStyle.None},
          textColor = {0, 0, 0},
          horizontalAlignment = TextAlignment.Left)}));
        Modelica.Blocks.Sources.Sine sine(f=1) 
          annotation(Placement(transformation(origin = {-149.6062, 8.5},
          extent = {{-17, -17}, {17, 17}})));
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation(Placement(transformation(origin = {110, 0},
          extent = {{-10, -10}, {10, 10}})));
        Modelica.Blocks.Continuous.Der der1 
          annotation(Placement(transformation(origin = {-88.6062, -7.82},
          extent = {{-10, -10}, {10, 10}})));
        FixDerIssue2 FixDerIssue2_1 
          annotation(Placement(transformation(origin = {-27.8562, 0},
          extent = {{-25.25, -17}, {25.25, 17}})));
      equation
        connect(der1.u, sine.y) 
          annotation(Line(origin = {-119.6062, -18},
          points = {{19, 10.18}, {9, 10.18}, {9, 26.5}, {-11.3, 26.5}},
          color = {0, 0, 127}));
        connect(FixDerIssue2_1.u, sine.y) 
          annotation(Line(origin = {-90.6062, -2},
          points = {{32.45, 10.5}, {-40.3, 10.5}},
          color = {0, 0, 127}));
        connect(der1.y, FixDerIssue2_1.u_der) 
          annotation(Line(origin = {-63.6062, -23},
          points = {{-14, 15.18}, {5.45, 15.18}},
          color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
        connect(FixDerIssue2_1.y, y) 
          annotation(Line(origin = {6, 53},
          points = {{-6.0812, -52.32}, {104, -52.32}, {104, -53}},
          color = {0, 0, 127}));
      end UseFixDerIssue2;

      model UseFixDerIssue3 "Examples of Using InputAdapter of the Zeros Derivatives Type"
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}},
          grid = {2, 2}), graphics = {Text(origin = {-12.25, 48.250875},
          lineColor = {0, 0, 0},
          extent = {{-32.25, -7.74912}, {32.25, 7.74912}},
          textString = "For piecewise signals, zeros derivatives can be used.",
          fontSize = 14,
          textStyle = {TextStyle.None},
          textColor = {0, 0, 0},
          horizontalAlignment = TextAlignment.Left)}));
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation(Placement(transformation(origin = {110, -2},
          extent = {{-10, -10}, {10, 10}})));
        FixDerIssue3 FixDerIssue3_1 
          annotation(Placement(transformation(origin = {-12.25, -2.776},
          extent = {{-32.25, -19.4}, {32.25, 19.4}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table = {{0.0, 0}, {0.2, 0}, {0.2, 1}, {0.5, 1}, {0.5, 2}, {1, 2}}) 
          annotation(Placement(transformation(origin = {-124, -2.8},
          extent = {{-10, -10}, {10, 10}})));
      equation
        connect(y, FixDerIssue3_1.y) 
          annotation(Line(origin = {-10, 61},
          points = {{120, -63}, {33.225, -63}},
          color = {0, 0, 127}));
        connect(combiTimeTable.y[1], FixDerIssue3_1.u) 
          annotation(Line(origin = {-164, -1.6},
          points = {{51, -1.2}, {113.05, -1.2}, {113.05, -0.4}},
          color = {0, 0, 127}));
      end UseFixDerIssue3;

    end Examples;

    package Types
      extends Modelica.Icons.TypesPackage;

      type InputHandling = String "Type of Input Adapter" 
        annotation(choices(
        choice = "ProvideSignals",
        choice = "ApproximateDerivatives",
        choice = "ZerosDerivatives"),
        Documentation(info = "<html>
    <p>
    <strong>InputHandling</strong> is a String type, which is made into an option box and available for users to select in the component parameter interface:
    </p>
    <p>
    1. <strong>ProvideSignals</strong>: The derivative signal is provided by the user. If the input signal and the derivative signal do not match, the final simulation results may not be accurate.
    </p>
    <p>
    2. <strong>ApproximateDerivatives</strong> (default option, and recommended option): The derivative is provided by Modelica.Blocks.Continuous.Derivative through an approximate derivative of the input signal, and the user needs to provide the difference parameter T (default value is 0.001).
    </p>
    <p>
    3. <strong>Zeros Derivatives</strong>: The derivative value is always 0, which is only suitable for piecewise constant cases. If the input signal is sampled from a continuous signal, the final simulation results may not be accurate.
    </p>
    </html>"    ));
      type ProvideSignals = String "Provide Signals" 
        annotation(choices(
        choice = "InputOnly",
        choice = "InputAndFirstDerivative",
        choice = "InputAndFirstTwoDerivatives"),
        Documentation(info = "<html>
    <p>
    <strong>ProvideSignals</strong> is a String type, which is made into an option box and available for users to select in the component parameter interface:
    </p>
    <p>
    <strong>InputOnly</strong>: consistent with the effect of not using this module.
    </p>
    <p>
    <strong>InputAndFirstDerivative</strong> (default option): an additional first-order derivative needs to be provided.
    </p>
    <p>
    <strong>InputAndFirstTwoDerivatives</strong>: an additional first-order derivative and second-order derivative need to be provided.
    </p>
    <p>
    This option is only effective when the user selects the input signal adapter category as <strong>ProvideSignals</strong>.
    </p>
    </html>"        ));
      type ApproxDerivatives = String "ApproxDerivatives" 
        annotation(choices(
        choice = "FirstOrderApproximateDerivative",
        choice = "SecondOrderApproximateDerivative"),
        Documentation(info = "<html>
    <p>
    The <strong>ApproxDerivatives</strong> is a String type, which is made into an option box and available for users to select in the component parameter interface:
    </p>
    <p>
    1. <strong>FirstOrderApproximateDerivative</strong> (default option): The derivative is approximated by Modelica.Blocks.Continuous.Derivative, and the user needs to provide the difference parameter T (default value is 0.001).
    </p>
    <p>
    2. <strong>SecondOrderApproximateDerivative</strong>: This is equivalent to two first-order approximate derivatives connected in series.
    </p>
    <p>
    This option is only effective when the user selects the input adapter category as Approximate Derivatives.
    </p>
    </html>"        ));

    end Types;
    package Functions
      extends Modelica.Icons.FunctionsPackage;

      function fstate0 "Return state(derivative function is 0)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real dummy;
        output Real s;
      algorithm
        s := u;
        annotation(derivative(noDerivative = u) = fstate0der1,
          InlineAfterIndexReduction = true);
      end fstate0;
      function fstate0der1 "Return first-order derivative 0 (derivative function of fstate0)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real dummy;
        input Real dummy_der;
        output Real sder1;
      algorithm
        sder1 := 0;
        annotation(derivative(noDerivative = u, order = 2) = fstate0der2, InlineAfterIndexReduction = true);
      end fstate0der1;
      function fstate0der2 "Return second-order derivative 0 (derivative function of fstate0der1)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real dummy;
        input Real dummy_der;
        input Real dummy_der2;
        output Real sder2;
      algorithm
        sder2 := 0;
        annotation(InlineAfterIndexReduction = true);
      end fstate0der2;
      function fstate1 "Return state (first-order differentiable function)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real u1 "first-order derivative value";
        input Real dummy;
        output Real s;
      algorithm
        s := u;
        annotation(derivative(noDerivative = u, noDerivative = u1) = fstate1der1,
          InlineAfterIndexReduction = true);
      end fstate1;
      function fstate1der1 "Return first-order derivative (derivative function of fstate1)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real u1 "first-order derivative value";
        input Real dummy;
        input Real dummy_der;
        output Real sder1;
      algorithm
        sder1 := u1;
        annotation(InlineAfterIndexReduction = true);
      end fstate1der1;
      function fstate2 "Return state (second-order differentiable function)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real u1 "first-order derivative value";
        input Real u2 "second-order derivative value";
        input Real dummy;
        output Real s;
      algorithm
        s := u;
        annotation(derivative(noDerivative = u, noDerivative = u1, noDerivative = u2) = fstate2der1,
          InlineAfterIndexReduction = true);
      end fstate2;
      function fstate2der1 "Return first-order derivative (derivative function of fstate2)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real u1 "first-order derivative value";
        input Real u2 "second-order derivative value";
        input Real dummy;
        input Real dummy_der;
        output Real sder1;
      algorithm
        sder1 := u1;
        annotation(derivative(noDerivative = u, noDerivative = u1, noDerivative = u2, order = 2) = fstate2der2,
          InlineAfterIndexReduction = true);
      end fstate2der1;
      function fstate2der2 "Return second-order derivative (derivative function of fstate2der1)"
        extends Modelica.Icons.Function;
        input Real u;
        input Real u1 "first-order derivative value";
        input Real u2 "second-order derivative value";
        input Real dummy;
        input Real dummy_der;
        input Real dummy_der2;
        output Real sder2;
      algorithm
        sder2 := u2;
        annotation(InlineAfterIndexReduction = true);
      end fstate2der2;

    end Functions;
  end TYAdapters;
end Interfaces;