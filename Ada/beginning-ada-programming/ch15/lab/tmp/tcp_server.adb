-- tcp_server.adb:

with Ada.Text_IO;
with Ada.IO_Exceptions;
with Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;

with GNAT.Sockets;



procedure TCP_Server is
  package SU renames Ada.Strings.Unbounded;

  Receiver   : GNAT.Sockets.Socket_Type;
  Connection : GNAT.Sockets.Socket_Type;
  Client     : GNAT.Sockets.Sock_Addr_Type;
  Channel    : GNAT.Sockets.Stream_Access;

  Server_Data : constant SU.Unbounded_String :=
    SU.To_Unbounded_String("I like cake!");
  Server_Data2 : String(1 .. 16)     := (others => ' ');
  Server_Data3 : Su.Unbounded_String := SU.Null_Unbounded_String;
begin
  GNAT.Sockets.Create_Socket(Receiver, GNAT.Sockets.Family_Inet, GNAT.Sockets.Socket_Stream);
  GNAT.Sockets.Set_Socket_Option(Receiver, GNAT.Sockets.Socket_Level, (GNAT.Sockets.Reuse_Address, True));
  GNAT.Sockets.Bind_Socket(Receiver, (GNAT.Sockets.Family_Inet, GNAT.Sockets.Inet_Addr("127.0.0.1"), 50000));
  GNAT.Sockets.Listen_Socket(Receiver);

  Ada.Text_IO.Put_Line(" !! TCP Server started !!");

  loop
    GNAT.Sockets.Accept_Socket(Receiver, Connection, Client);

    Ada.Text_IO.Put_Line("Client connected from " & GNAT.Sockets.Image(Client));
    Channel := GNAT.Sockets.Stream(Connection);

    begin
      loop
        -- String'Read(Channel, Server_Data2);
        -- SU.Append(Server_Data3, Server_Data2);
        SU.Unbounded_String'Read(Channel, Server_Data3);
        SU.Unbounded_String'Write(Channel, Server_Data);
      end loop;
    exception
      when Ada.IO_Exceptions.End_Error =>
        Ada.Text_IO.Unbounded_IO.Put_Line(Server_Data3);
    end;

    GNAT.Sockets.Close_Socket(Connection);
  end loop;
end TCP_Server;

