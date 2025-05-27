connector OuterMemory = Real "'outer memory' as connector" annotation(__MWORKS(MemoryRef),defaultComponentName = "X", defaultComponentPrefixes = "outer", Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2}),graphics = {Rectangle(origin={0,0}, 
lineColor={0,0,127}, 
fillColor={255,255,255}, 
fillPattern=FillPattern.Solid, 
extent={{-100,100},{100,-100}}), Line(origin={0,70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
pattern=LinePattern.Dash, 
thickness=2), Line(origin={0,-70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
pattern=LinePattern.Dash, 
thickness=2), Text(origin={-3,-3}, 
lineColor={0,0,127}, 
extent={{-77,23},{77,-23}}, 
textString="%name", 
textStyle={TextStyle.None}, 
textColor={0,0,127})}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})),Documentation(info="<html><p>
Write data to or read data from a specified InnerMemory memory region, which can be read multiple times and can only be written once.
</p>
</html>"));