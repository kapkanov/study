-- main_animal.adb:

with Ada.Text_IO;

with Animal;

procedure main_animal is
  Var1 : Animal.Creature := Animal.Init;
  Var2 : Animal.Creature := Animal.Init("Elephant", 4, 4000000, 500);
begin
  Animal.Print_Record(Var1);
  Animal.Print_Record(Var2);
  -- Animal.Private_Print_Record(Var2); ERROR
  Animal.Set_Name(Var2, "Godzilla");
  Ada.Text_IO.Put_Line(Animal.Get_Name(Var2));
end main_animal;
