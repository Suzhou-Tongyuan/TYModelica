connector InnerMemory = OuterMemory "'inner memory' as connector"  annotation(__MWORKS(Memory), defaultComponentName = "X", defaultComponentPrefixes = "inner",Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2}),graphics = {Rectangle(origin={0,0}, 
lineColor={0,0,127}, 
fillColor={255,255,255}, 
fillPattern=FillPattern.Solid, 
extent={{-100,100},{100,-100}}), Line(origin={0,70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
thickness=2), Line(origin={0,-70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
thickness=2), Text(origin={-3,-3}, 
lineColor={0,0,127}, 
extent={{-77,23},{77,-23}}, 
textString="%name", 
textStyle={TextStyle.None}, 
textColor={0,0,127})}),Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})),Documentation(info="<html><p>
Defines a memory region used by OuterMemory.All OuterMemory that are in the current subsystem &nbsp;have the same data store name will be able to read from and write to this model.
</p>
</html>"));