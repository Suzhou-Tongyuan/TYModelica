﻿within Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Transformers.Yd;
model Yd09 "Transformer Yd9"

  extends QuasiStatic.Machines.Interfaces.PartialBasicTransformer(final
      VectorGroup="Yd09");
  QuasiStatic.Polyphase.Basic.Star star1(final m=m) annotation (Placement(
        transformation(
        origin={-10,-80}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  QuasiStatic.SinglePhase.Interfaces.NegativePin starpoint1 
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  QuasiStatic.Polyphase.Basic.Delta Delta2(final m=m) 
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  QuasiStatic.Polyphase.Basic.Delta Rot2(final m=m) 
    annotation (Placement(transformation(extent={{50,10},{30,30}})));
equation
  connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
          -10,-100},{-50,-100}}, color={85,170,255}));
  connect(Rot2.plug_p, l2sigma.plug_p) 
    annotation (Line(points={{50,20},{50,0}}, color={85,170,255}));
  connect(Delta2.plug_n, r2.plug_n) annotation (Line(points={{50,-20},{
          90,-20},{90,0}}, color={85,170,255}));
  connect(l1sigma.plug_n, core.plug_p1) annotation (Line(points={{-50,0}, 
          {-50,20},{-10,20},{-10,5}}, color={85,170,255}));
  connect(core.plug_n1, star1.plug_p) annotation (Line(points={{-10,-5}, 
          {-10,-37.5},{-10,-70},{-10,-70}}, color={85,170,255}));
  connect(core.plug_n2, core.plug_p3) 
    annotation (Line(points={{10,4},{10,-4}}, color={85,170,255}));
  connect(core.plug_p2, Rot2.plug_n) annotation (Line(points={{10,10},{
          10,20},{30,20}}, color={85,170,255}));
  connect(core.plug_n3, Delta2.plug_p) annotation (Line(points={{10,-10}, 
          {10,-20},{30,-20}}, color={85,170,255}));
  annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yd9
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"));
end Yd09;