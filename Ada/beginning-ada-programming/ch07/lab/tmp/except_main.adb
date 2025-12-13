with Ada.Text_IO;

with Except_Animal;

procedure Except_Main is
  Var1 : Except_Animal.Creature := Except_Animal.Init;
  Var2 : Except_Animal.Creature := Except_Animal.Init("Elephant", 4, 4000000, 500);
  Var3 : Except_Animal.Creature := Except_Animal.Init("Rose", 1000, 4000000, 2001);
begin
  Except_Animal.Print_Record(Var1);
  Except_Animal.Print_Record(Var2);
  --Animal.Private_Print_Record(Var2); ERROR
end Except_Main;

