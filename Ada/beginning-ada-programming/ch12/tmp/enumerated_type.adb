-- enumerated_type.adb:

with Ada.Text_IO;

procedure Enumerated_Type is
  type Robot_Actions is (forward, turn_left, turn_right,
    rotate_left, rotate_right, stop);
  Vacuum_Bot : Robot_Actions := stop;

  procedure Process_Action(Machine_Action : in Robot_Actions) is
  begin
    case Machine_Action is
      when forward =>
        Ada.Text_IO.Put_Line("The robot is moving forward.");
      when turn_left =>
        Ada.Text_IO.Put_Line("The robot is turning left.");
      when turn_right =>
        Ada.Text_IO.Put_Line("The robot is turning right.");
      when rotate_left =>
        Ada.Text_IO.Put_Line("The robot is rotating to the left.");
      when rotate_right =>
        Ada.Text_IO.Put_Line("The robot is rotating to the right.");
      when others =>
        Ada.Text_IO.Put_Line("The robot is stopped.");
    end case;
  end Process_Action;
begin
  Process_Action(Vacuum_Bot);
  Vacuum_Bot := forward;
  Process_Action(Vacuum_Bot);
  Vacuum_Bot := turn_left;
  Process_Action(Vacuum_Bot);
  Vacuum_Bot := rotate_right;
  Process_Action(Vacuum_Bot);
  Vacuum_Bot := forward;
  Process_Action(Vacuum_Bot);
  Vacuum_Bot := turn_right;
  Process_Action(Vacuum_Bot);
  Vacuum_Bot := forward;
  Process_Action(Vacuum_Bot);
  Vacuum_Bot := stop;
  Process_Action(Vacuum_Bot);
end Enumerated_Type;
