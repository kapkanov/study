with Ada.Text_IO;



procedure Hole is


  type Buffer_Type is array (0 .. 9) of Integer;

  Buffer : Buffer_Type := (others => 0);
  Head   : Natural     := 0;
  Tail   : Natural     := 0;


  procedure Push(Element : in Integer) is
  begin
    if (Tail + 1) rem Buffer'Length = Head then
      Ada.Text_IO.Put_Line("Ringbuffer is full");
      return;
    end if;

    Buffer(Tail) := Element;
    Tail         := (Tail + 1) rem Buffer'Length;
  end Push;


  function Pop return Integer is
    Tmp : Integer := 0;
  begin
    if Head = Tail then
      Ada.Text_IO.Put_Line("Ringbuffer is empty");
      return 0;
    end if;

    Tmp  := Buffer(Head);
    Head := (Head + 1) rem Buffer'Length;

    return Tmp;
  end Pop;


  Tmp : Integer := -1;
begin
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
  for j in 1 .. 11 loop
    Push(j * j);
    Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
  end loop;

  Ada.Text_IO.Put_Line(ASCII.LF & "Popping 3 times in a row:");
  Tmp := Pop;
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
  Tmp := Pop;
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
  Tmp := Pop;
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);

  Ada.Text_IO.Put_Line(ASCII.LF & "Pushing 4 times in a row:");
  Push(123);
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
  Push(456);
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
  Push(789);
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
  Push(101);
  Ada.Text_IO.Put_Line(Head'Image & ASCII.HT & Tail'Image);
end Hole;

