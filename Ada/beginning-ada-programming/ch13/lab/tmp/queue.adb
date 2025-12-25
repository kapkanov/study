with Ada.Text_IO;



package body Queue is
  type Table is array (Positive range <>) of T;

  Space : Table(1 .. Size);
  First : Natural := 0;
  Last  : Natural := 1;


  procedure Push(Element : T) is
  begin
    if Last = Size + 1 then
      Ada.Text_IO.Put_Line("ERROR: The Queue is full");
    else
      Space(Last) := Element;
      Last        := Last + 1;
    end if;
  end Push;


  function Pop return T is
  begin
    if First = Last - 1 then
      Ada.Text_IO.Put_Line("ERROR: The Queue is empty");
    else
      First := First + 1;
    end if;
    return Space(First);
  end Pop;
end Queue;

