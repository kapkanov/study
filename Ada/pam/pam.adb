with Ada.Text_IO;
with Interfaces;
with Ada.Streams;
with Ada.Streams.Stream_IO;
with Ada.Strings;
with Ada.Strings.Fixed;


procedure pam is
  use type Interfaces.Unsigned_8;

  type Pixel is record
    R, G, B : Interfaces.Unsigned_8 := 0;
    A       : Interfaces.Unsigned_8 := 255;
  end record;

  for Pixel use record
    R at 0 range  0 .. 7;
    G at 0 range  8 .. 15;
    B at 0 range 16 .. 23;
    A at 0 range 24 .. 31;
  end record;

  for Pixel'Size      use 32;
  for Pixel'Alignment use 1;

  Screen_Width  : constant := 16 * 60;
  Screen_Height : constant :=  9 * 60;

  type Pixel_Array_Type is array (0 .. Screen_Width * Screen_Height - 1) of Pixel;
  pragma Convention(C, Pixel_Array_Type);

  for Pixel_Array_Type'Component_Size use 32;

  Pixel_Array : Pixel_Array_Type;

  Total_Bytes : constant Ada.Streams.Stream_Element_Offset := Ada.Streams.Stream_Element_Offset(Pixel_Array'Size / 8);

  subtype View_Type is Ada.Streams.Stream_Element_Array (1 .. Total_Bytes);

  View: View_Type;
  for View'Address use Pixel_Array'Address;
  pragma Import(Ada, View);

  File   : Ada.Streams.Stream_IO.File_Type;
  Stream : Ada.Streams.Stream_IO.Stream_Access;

  Header : constant String :=
    "P7" & ASCII.LF
    & "WIDTH " & Ada.Strings.Fixed.Trim(Screen_Width'Image, Ada.Strings.Left) & ASCII.LF
    & "HEIGHT " & Ada.Strings.Fixed.Trim(Screen_Height'Image, Ada.Strings.Left) & ASCII.LF
    & "DEPTH 4" & ASCII.LF
    & "MAXVAL 255" & ASCII.LF
    & "TUPLTYPE RGB_ALPHA" & ASCII.LF
    & "ENDHDR" & ASCII.LF;
begin
  for Y in 0 .. Screen_Height - 1 loop
    for X in 0 .. Screen_Width - 1 loop
      if (X / 60 + Y / 60) mod 2 = 0 then
        Pixel_Array(Y * Screen_Width + X) := (
          R => 255,
          G => 0,
          B => 0,
          A => 255
        );
      else
        Pixel_Array(Y * Screen_Width + X) := (
          R => 0,
          G => 0,
          B => 0,
          A => 255
        );
      end if;
    end loop;
  end loop;

  Ada.Streams.Stream_IO.Create(File, Ada.Streams.Stream_IO.Out_File, "out.pam");
  Stream := Ada.Streams.Stream_IO.Stream(File);

  String'Write(Stream, Header);

  View_Type'Write(Stream, View);

  Ada.Streams.Stream_IO.Close(File);
end pam;

