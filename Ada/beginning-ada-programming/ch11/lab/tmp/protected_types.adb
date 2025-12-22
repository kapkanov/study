-- protected_types.adb:

with Ada.Text_IO;
with Ada.Strings.Unbounded;



procedure Protected_Types is
  type Address_Type is record
    Str    : Ada.Strings.Unbounded.Unbounded_String :=
      Ada.Strings.Unbounded.Null_Unbounded_String;
  end record;


  protected type Protected_Value is
    entry Insert(Str : in Ada.Strings.Unbounded.Unbounded_String);
    entry Retrieve(Address : out Address_Type);
  private
    Address_Internal : Address_Type;
    Accessible       : Boolean := True;
  end Protected_Value;

  protected body Protected_Value is
    entry Insert(Str : in Ada.Strings.Unbounded.Unbounded_String)
        when Accessible is
    begin
      Accessible           := False;
      Address_Internal.Str := Str;
    end Insert;

    entry Retrieve(Address : out Address_Type) when not Accessible is
    begin
      Address    := Address_Internal;
      Accessible := True;
    end Retrieve;
  end Protected_Value;

  Protected_01 : Protected_Value;


  task type Access_Protected(Identifier : Integer) is
    entry Start(Input : in Ada.Strings.Unbounded.Unbounded_String);
    entry Quit;
  end Access_Protected;

  task body Access_Protected is
    Go_Loop           : Boolean                                := True;
    Task_Custom_Value : Ada.Strings.Unbounded.Unbounded_String :=
      Ada.Strings.Unbounded.Null_Unbounded_String;
    Task_Return_Value : Address_Type;
    Serial_Number     : Integer                                :=
      Identifier;
  begin
    accept Start(Input : in Ada.Strings.Unbounded.Unbounded_String) do
      Ada.Text_IO.Put_Line("Task in start entry!");
      Task_Custom_Value := Input;
    end Start;

    while Go_Loop loop
      select
        accept Quit do
          Ada.Text_IO.Put_Line("Task is asked to exit!");

          Go_Loop := False;
        end Quit;
      else
        select
          Protected_01.Insert(Task_Custom_Value);
          delay 0.1;
          Protected_01.Retrieve(Task_Return_Value);
          Ada.Text_IO.Put_Line("The return value: [ " & Ada.Strings.Unbounded.To_String(Task_Return_Value.Str) & " ] in task => " & Integer'Image(Serial_Number));
        or delay 1.0;
          Ada.Text_IO.Put_Line(" <=> ERROR! Did not acquire resource!");
        end select;
      end select;
    end loop;
  end Access_Protected;

  Task_01 : Access_Protected(Identifier => 1);
  Task_02 : Access_Protected(Identifier => 2);
  Task_03 : Access_Protected(Identifier => 3);
  Task_04 : Access_Protected(Identifier => 4);
  Task_05 : Access_Protected(Identifier => 5);
begin
  Task_01.Start(Ada.Strings.Unbounded.To_Unbounded_String("Task_01"));
  Task_02.Start(Ada.Strings.Unbounded.To_Unbounded_String("Task_02"));
  Task_03.Start(Ada.Strings.Unbounded.To_Unbounded_String("Task_03"));
  Task_04.Start(Ada.Strings.Unbounded.To_Unbounded_String("Task_04"));
  Task_05.Start(Ada.Strings.Unbounded.To_Unbounded_String("Task_05"));

  delay 6.0;

  Task_01.Quit;
  Task_02.Quit;
  Task_03.Quit;
  Task_05.Quit;
  Task_04.Quit;

end Protected_Types;

