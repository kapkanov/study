with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Directories;
use  type Ada.Directories.File_Kind;

procedure data_crunching is
  File_Name     : String(1 .. 64);
  File_Name_Len : Natural := 0;
  File_Handle   : Ada.Text_IO.File_Type;

begin
  if Ada.Command_Line.Argument_Count < 1 then
    Ada.Text_IO.Put_Line("You should provide at least 1 argument");
    return;
  end if;

  File_Name_Len                 := Ada.Command_Line.Argument(1)'Length;
  File_Name(1 .. File_Name_Len) := Ada.Command_Line.Argument(1);

  if 
    Ada.Directories.Exists(File_Name(1 .. File_Name_Len))
    and then Ada.Directories.Kind(File_Name(1 .. File_Name_Len)) = Ada.Directories.Ordinary_File
  then
    Ada.Text_IO.Open(
      File => File_Handle,
      Mode => Ada.Text_IO.In_File,
      Name => File_Name(1 .. File_Name_Len)
    );
  else
    Ada.Text_IO.Put_Line("File " & File_Name(1 .. File_Name_Len) & " not found");
    return;
  end if;

  while not Ada.Text_IO.End_Of_File(File_Handle) loop
    declare
      Line : String := Ada.Text_IO.Get_Line(File_Handle);
    begin
      for j in Line'Range loop
        if 
          Line(j) = 'A'
          and then j + 2 <= Line'Length
        then
          if Line(j .. j + 2) = "Ada" then
            Line(j .. j + 2) := "ADA";
          end if;
        end if;
        Ada.Text_IO.Put(Line(j));
      end loop;
      Ada.Text_IO.New_Line;
    end;
  end loop;

  Ada.Text_IO.Close(File => File_Handle);

end data_crunching;

