with Ada.Text_IO;

procedure xor_custom is
  val1 : Boolean := False;
  val2 : Boolean := False;
  res  : Boolean := False;
begin
  val1 := True;
  val2 := True;
  res  := not (val1 and val2) and (val1 or val2);
  Ada.Text_IO.Put_Line(Boolean'Image(val1) & "  XOR " & Boolean'Image(val2) & "  = " & Boolean'Image(res));

  val1 := True;
  val2 := False;
  res  := not (val1 and val2) and (val1 or val2);
  Ada.Text_IO.Put_Line(Boolean'Image(val1) & "  XOR " & Boolean'Image(val2) & " = " & Boolean'Image(res));

  val1 := False;
  val2 := True;
  res  := not (val1 and val2) and (val1 or val2);
  Ada.Text_IO.Put_Line(Boolean'Image(val1) & "  XOR " & Boolean'Image(val2) & " = " & Boolean'Image(res));

  val1 := False;
  val2 := False;
  res  := not (val1 and val2) and (val1 or val2);
  Ada.Text_IO.Put_Line(Boolean'Image(val1) & " XOR " & Boolean'Image(val2) & " = " & Boolean'Image(res));
end xor_custom;

