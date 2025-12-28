with Ada.Text_IO;
with Mouse_Trap;



procedure Mouse_Main is
begin
  Ada.Text_IO.Put_Line(Mouse_Trap.Is_Locked'Image);
  Mouse_Trap.Check_Platform(0.11);
  Ada.Text_IO.Put_Line(Mouse_Trap.Is_Locked'Image);
  Mouse_Trap.Reset;
  Ada.Text_IO.Put_Line(Mouse_Trap.Is_Locked'Image);
  Mouse_Trap.Check_Platform(0.11);
  Ada.Text_IO.Put_Line(Mouse_Trap.Is_Locked'Image);
end Mouse_Main;

