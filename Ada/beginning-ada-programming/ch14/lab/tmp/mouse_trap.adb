package body Mouse_Trap is
  function Is_Locked return Boolean is
  begin
    return Locked;
  end Is_Locked;


  procedure Check_Platform(Weight : in Float) is
  begin
    if Weight > 0.1 then
      Locked := True;
    end if;
  end Check_Platform;


  procedure Reset is
  begin
    Locked := False;
  end Reset;

end Mouse_Trap;
