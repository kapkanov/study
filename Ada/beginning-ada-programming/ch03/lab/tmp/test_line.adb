with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Line is
   Line : String := "123";
   subtype Line_Len is Natural range 0 .. 3;
   Len : Line_Len := 0;
begin
   while not End_Of_File loop
      Get_Line(Line, Len);
      Put_Line("Len=" & Natural'Image(Len));
   end loop;
end Test_Line;
