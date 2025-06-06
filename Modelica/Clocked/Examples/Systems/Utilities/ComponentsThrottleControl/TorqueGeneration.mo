﻿within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
block TorqueGeneration "Torque generation"
extends Modelica.Blocks.Icons.Block;
  parameter Real AFR = 14.6 
    "Air-fuel ratio";
  parameter Real sigma = 15.0 
    "Spark advance, BTDC";
  Modelica.Blocks.Interfaces.RealInput m_a(unit="g") 
    "Mass of air charge in cylinder (delayed of 180deg crankshaft rotation) (g)" 
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput N(unit="rad/s") "Engine speed (rad/sec)" 
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_torque_e(unit="N.m") 
    "Torque generated by engine" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

 T_torque_e = -181.3 + 379.36*m_a + 21.91*AFR - 0.85*AFR^2 + 0.26*sigma 
 - 0.0028*sigma^2 + 0.027*N - 0.000107*N^2 + 0.00048*N*sigma 
 + 2.55*sigma*m_a - 0.05*sigma^2*m_a;
end TorqueGeneration;