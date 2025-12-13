with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure guess_which_value is
  Line          : String(1..3) := "000";
  Last          : Natural      := 0;
  Number_Actual  : Integer      := 1;
  Number_Expected : Integer      := 2;

  subtype Number_Range is Integer range 1 .. 10;
  package Random_Number is new Ada.Numerics.Discrete_Random(Number_Range);
  Generator     : Random_Number.Generator;
begin
  Random_Number.Reset(Generator);

  Ada.Text_IO.Get_Line(Line, Last);
  Number_Actual  := Integer'Value(Line(1..Last));
  Ada.Text_IO.Put_Line("Line = " & Line);
  Ada.Text_IO.Put_Line("Last = " & Integer'Image(Last));

  Number_Expected := Random_Number.Random(Generator);

  if Number_Actual = Number_Expected then
    Ada.Text_IO.Put_Line("Your guess is correct! The expected number is "
                         & Integer'Image(Number_Expected));
  else
    Ada.Text_IO.Put_Line("You guess is incorrect! The expected number is "
			 & Integer'Image(Number_Expected)
			 & " but you typed "
			 & Integer'Image(Number_Actual));
  end if;
end guess_which_value;

