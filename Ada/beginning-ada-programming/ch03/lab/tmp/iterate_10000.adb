with Ada.Text_IO;

procedure iterate_10000 is
begin
  for j in 1 .. 10_000 loop
    if (j rem 3 = 0) and (j rem 13 = 0) and (j rem 23 = 0) then
      Ada.Text_IO.Put_Line(Positive'Image(j));
    end if;
  end loop;
end iterate_10000;

