with Ada.Text_IO;

procedure hello_world_methods is
  procedure hello_world is
  begin
    Ada.Text_IO.Put_Line("Hello World!");
  end hello_world;

  procedure wonderful_day is
  begin
    Ada.Text_IO.Put("It's a wonderful day!");
  end wonderful_day;
  
  procedure new_line is
  begin
    Ada.Text_IO.New_Line;
  end new_line;
begin
  hello_world;
  wonderful_day;
  new_line;
end hello_world_methods;

