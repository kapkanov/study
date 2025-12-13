-- declare_block.adb:

with Ada.Text_IO;

procedure declare_replacement is
  Counter : Natural := 0;

  procedure procedure_instead_of_declare(Cnt : out Natural) is
    Bool : Boolean := True;
  begin
    Cnt := 3;
    Ada.Text_IO.Put_Line("Inside the procedure:   " & Natural'Image(Cnt));
    Ada.Text_IO.Put_Line("The boolean:            " & Boolean'Image(Bool));
  end procedure_instead_of_declare;

begin
  Ada.Text_IO.Put_Line("Right before the declare: " & Natural'Image(Counter));

  procedure_instead_of_declare(Counter);

  --Ada.Text_IO.Put_Line("The boolean after declare: " & Natural'Image(Bool));
  Ada.Text_IO.Put_Line("Right after the declare:  " & Natural'Image(Counter));
end declare_replacement;

