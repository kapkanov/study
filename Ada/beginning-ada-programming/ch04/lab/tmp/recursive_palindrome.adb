with Ada.Text_IO;
with Ada.Characters.Handling;


procedure recursive_palindrome is

  function is_palindrome(Str : String) return Boolean is
    CharFirst : Character := 'a';
    CharLast  : Character := 'b';
  begin
    if Str'Length = 0 then
      return True;
    else
      CharFirst := Ada.Characters.Handling.To_Lower(Str(Str'First));
      CharLast  := Ada.Characters.Handling.To_Lower(Str(Str'Last));
      return CharFirst = CharLast and is_palindrome(Str(Str'First + 1 .. Str'Last - 1));
    end if;
  end is_palindrome;

begin
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("1")));        -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("a")));        -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("aa")));       -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("aba")));      -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("abba")));     -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("ab")));       -- FALSE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("abc")));      -- FALSE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("abca")));     -- FALSE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("Aba")));      -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("RaceCar")));  -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome(" ")));        -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("  ")));       -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("a b a")));    -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("@#@")));      -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("@#a#@")));    -- TRUE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("ab!!ca")));   -- FALSE
  Ada.Text_IO.Put_Line(Boolean'Image(is_palindrome("")));         -- TRUE
end recursive_palindrome;

