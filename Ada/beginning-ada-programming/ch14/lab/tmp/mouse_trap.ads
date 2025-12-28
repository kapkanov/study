pragma Assertion_Policy(Check);



package Mouse_Trap is
  function  Is_Locked return Boolean;
  procedure Check_Platform(Weight : in Float) with Pre => Is_Locked = False;
  procedure Reset with Pre => Is_Locked = True;

private
  Locked : Boolean := False;
end Mouse_Trap;

