with Ada.Text_IO;

with Queue;


procedure Generic_Main is
  package Queue_Integer is new Queue(
    Size => 10,
    T    => Integer
  );
begin
  for j in 1 .. 12 loop
    Queue_Integer.Push(173);
  end loop;
end Generic_Main;

