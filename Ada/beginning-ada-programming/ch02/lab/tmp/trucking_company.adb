with Ada.Text_IO;
with Ada.Float_Text_IO;

procedure trucking_company is
  oilChange : Float := 440.0;
  washingFluid : Float := 98.4;
  airFilter : Float := 23.0;
  fuel1 : Float := 900.4;
  pizza : Float := 71.49;
  fuel2 : Float := 90.01;
begin
  Ada.Text_IO.Put_Line("hola");
  Ada.Float_Text_IO.Put(oilChange + washingFluid + airFilter + fuel1 + pizza + fuel2, Exp => 0);
end trucking_company;

