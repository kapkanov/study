-- company.adb:
--
-- How to compile this code:
--  $ gnatmake -g company.adb

with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;
with Ada.Strings.Unbounded;
with Ada.Float_Text_IO;
with Ada.Text_IO;

procedure company is
  type Salary_Type           is range 1 .. 5000000;
  type Years_Of_Service_Type is range 0 ..      20;
  type Vacation_Hours_Type   is delta 0.1 range 0.0 .. 1000.0;
  type Sick_Time_Type        is delta 0.1 range 0.0 .. 500.0;

  type Employee is record
    First_Name : Ada.Strings.Unbounded.Unbounded_String :=
      Ada.Strings.Unbounded.To_Unbounded_String("");
    Last_Name : Ada.Strings.Unbounded.Unbounded_String  :=
      Ada.Strings.Unbounded.To_Unbounded_String("");
    Title : Ada.Strings.Unbounded.Unbounded_String      :=
      Ada.Strings.Unbounded.To_Unbounded_String("");
    Salary : Salary_Type                                := 1;
    Vacation_Hours : Vacation_Hours_Type                := 0.0;
    Sick_Time : Sick_Time_Type                          := 0.0;
    Years_Of_Service : Years_Of_Service_Type            := 0;
  end record;

  Employees : array(1 .. 10) of Employee;

  -- create a positive value that is within a specific range.
  --  NOTE: Although it is not explicitly mentioned and not checked for, your From needs to be smaller than your To input.  You could, in your example, create
  --   a wrapper function that you call beforehand that will do the checking and then call the below method.
  function Create_Random_Positive(
    Offset : in Natural;
    Range_Val : in Natural)
      return Natural;

  -- create a float value that is within a specific range.
  --  NOTE: Although it is not explicitly mentioned and not checked for, your From needs to be smaller than your To input.  You could, in your example, create
  --   a wrapper function that you call beforehand that will do the checking and then call the below method.
  function Create_Random_Float(
    Offset : in Float;
    Range_Val : in Float)
      return Float;

  function Create_Random_Salary return Salary_Type;
  function Create_Random_Years return Years_Of_Service_Type;
  function Create_Random_Sick_Time return Sick_Time_Type;
  function Create_Random_Hours return Vacation_Hours_Type;

  -- this procedure will be used to instantiate the array of employees.
  procedure Inst_Employees is
  begin
    -- give the employees some names to start off with.
    Employees(1).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Robert");
    Employees(1).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Kraft");
    Employees(1).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Owner");
    Employees(2).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Bill");
    Employees(2).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Belichick");
    Employees(2).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Head Coach");
    Employees(3).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Tom");
    Employees(3).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Brady");
    Employees(3).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Quarterback");
    Employees(4).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Corey");
    Employees(4).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Dillon");
    Employees(4).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Running Back");
    Employees(5).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Randy");
    Employees(5).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Moss");
    Employees(5).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Wide Receiver");
    Employees(6).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Wes");
    Employees(6).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Welker");
    Employees(6).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Wide Receiver");
    Employees(7).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Troy");
    Employees(7).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Brown");
    Employees(7).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Wide Receiver");
    Employees(8).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Richard");
    Employees(8).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Seymour");
    Employees(8).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Defensive Tackle");
    Employees(9).First_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Ty");
    Employees(9).Last_Name   := Ada.Strings.Unbounded.To_Unbounded_String("Warren");
    Employees(9).Title       := Ada.Strings.Unbounded.To_Unbounded_String("Defensive Tackle");
    Employees(10).First_Name := Ada.Strings.Unbounded.To_Unbounded_String("Vince");
    Employees(10).Last_Name  := Ada.Strings.Unbounded.To_Unbounded_String("Willfork");
    Employees(10).Title      := Ada.Strings.Unbounded.To_Unbounded_String("Nose Tackle");

    -- now proceed to generate random values in a loop.
    for index in Employees'Range
    loop
      Employees(index).Salary := Create_Random_Salary;
      Employees(index).Years_Of_Service := Create_Random_Years;
      Employees(index).Sick_Time := Create_Random_Sick_Time;
      Employees(index).Vacation_Hours := Create_Random_Hours;
    end loop;
  end Inst_Employees;

  procedure Print_Employees is
  begin
    Ada.Text_IO.Put_Line("The current employees for the New England Patriots.");
    Ada.Text_IO.New_Line;

    for index in Employees'Range
    loop
      Ada.Text_IO.Put_Line(" The first name:    " & Ada.Strings.Unbounded.To_String(Employees(index).First_Name));
      Ada.Text_IO.Put_Line(" The last name:     " & Ada.Strings.Unbounded.To_String(Employees(index).Last_Name));
      Ada.Text_IO.Put_Line(" The title:         " & Ada.Strings.Unbounded.To_String(Employees(index).Title));
      Ada.Text_IO.Put_Line(" Salary:           " & Salary_Type'Image(Employees(index).Salary));
      -- in the following example, in order to suppress the default behavior of printing out the floats in scientific notation, I split up the printing code
      --  and had this done in steps while specifying that the floats should be printed out in a manner that is more widely accepted.
      Ada.Text_IO.Put(" Sick time:         ");
      Ada.Text_IO.Put(Sick_Time_Type'Image(Employees(index).Sick_Time));
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put(" Vacation hours:    ");
      Ada.Text_IO.Put(Vacation_Hours_Type'Image(Employees(index).Vacation_Hours));
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line(" Years of service: " & Years_Of_Service_Type'Image(Employees(index).Years_Of_Service));
      Ada.Text_IO.New_Line;
    end loop;
  end Print_Employees;

  function Create_Random_Years return Years_Of_Service_Type is
    package Random_Val is new Ada.Numerics.Discrete_Random(Result_Subtype => Years_Of_Service_Type);
    Gen : Random_Val.Generator;
  begin
    Random_Val.Reset(Gen => Gen);
    return Random_Val.Random(Gen => Gen);
  end Create_Random_Years;

  function Create_Random_Salary return Salary_Type is
    package Random_Val is new Ada.Numerics.Discrete_Random(Result_Subtype => Salary_Type);
    Gen : Random_Val.Generator;
  begin
    Random_Val.Reset(Gen => Gen);
    return Random_Val.Random(Gen => Gen);
  end Create_Random_Salary;

  function Create_Random_Positive(
    Offset : in Natural;
    Range_Val : in Natural)
      return Natural is

    subtype Vals is Natural range Offset .. Range_Val;
    package Random_Val is new Ada.Numerics.Discrete_Random(Result_Subtype => Vals);

    Gen : Random_Val.Generator;
  begin
    Random_Val.Reset(Gen => Gen);

    return Random_Val.Random(Gen => Gen);
  end Create_Random_Positive;

  function Create_Random_Hours return Vacation_Hours_Type is
    Seed : Ada.Numerics.Float_Random.Generator;
    Tmp  : Float;
  begin
    Ada.Numerics.Float_Random.Reset(Seed);
    Tmp := Float(Vacation_Hours_Type'First) + (Ada.Numerics.Float_Random.Random(Seed) * Float(Vacation_Hours_Type'Last));
    return Vacation_Hours_Type(Tmp);
  end Create_Random_Hours;

  function Create_Random_Sick_Time return Sick_Time_Type is
    Seed : Ada.Numerics.Float_Random.Generator;
    Tmp  : Float;
  begin
    Ada.Numerics.Float_Random.Reset(Seed);
    Tmp := Float(Sick_Time_Type'First) + (Ada.Numerics.Float_Random.Random(Seed) * Float(Sick_Time_Type'Last));
    return Sick_Time_Type(Tmp);
  end Create_Random_Sick_Time;

  function Create_Random_Float(
    Offset : in Float;
    Range_Val : in Float)
      return Float is

    Seed : Ada.Numerics.Float_Random.Generator;
  begin
    Ada.Numerics.Float_Random.Reset(Seed);

    return Offset + (Ada.Numerics.Float_Random.Random(Seed) * Range_Val);
  end Create_Random_Float;
begin
  Inst_Employees;

  Print_Employees;
end company;
