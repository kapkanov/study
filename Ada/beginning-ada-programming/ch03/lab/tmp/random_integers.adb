with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure random_integers is
  Line        : String         := "123";
  subtype LineLen is Natural range 0 .. 3;
  Len         : LineLen        := 1;

  NumberInput : Integer        := 0;

  subtype NumberExpected is Natural range 1 .. 100;
  package Random_Number is new Ada.Numerics.Discrete_Random(NumberExpected);
  NumberCheck : NumberExpected := 1;
  Gen         : Random_Number.Generator;

  BottomLimit : Integer        := 1;
  UpperLimit  : Integer        := 1;
begin
  Random_Number.Reset(Gen);
  NumberCheck := Random_Number.Random(Gen);

  if NumberCheck rem 10 = 0 then
    UpperLimit  := NumberCheck;
    BottomLimit := UpperLimit - 9;
  else
    BottomLimit := NumberCheck / 10 * 10 + 1;
    UpperLimit  := (NumberCheck + 9) / 10 * 10;
  end if;

  Ada.Text_IO.Put_Line("NumberCheck =" & Integer'Image(NumberCheck));
  Ada.Text_IO.Put_Line("BottomLimit =" & Integer'Image(BottomLimit));
  Ada.Text_IO.Put_Line("UpperLimit  =" & Integer'Image(UpperLimit));

  loop
    Ada.Text_IO.Get_Line(Line, Len);
    while Len = 0 loop
      Ada.Text_IO.Get_Line(Line, Len);
    end loop;
    NumberInput := Integer'Value(Line(Line'First .. Len));
    if BottomLimit <= NumberInput and NumberInput <= UpperLimit then
      Ada.Text_IO.Put_Line("Success!");
      exit;
    end if;
  end loop;

end;

