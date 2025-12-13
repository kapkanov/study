with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Characters.Handling;


procedure palindrome is
  IsPalindrome : Boolean := False;

  function is_palindrome(Str : Ada.Strings.Unbounded.Unbounded_String) return Boolean is
    StrLen    : Natural   := Ada.Strings.Unbounded.Length(Str);
    Mid       : Natural   := StrLen / 2 + 1;
    CharFirst : Character := 'a';
    CharLast  : Character := 'b';
  begin
    if StrLen = 0 then
      return True;
    end if;

    for j in 1 .. Mid loop
      CharFirst := Ada.Strings.Unbounded.Element(Str, j);
      CharLast  := Ada.Strings.Unbounded.Element(Str, StrLen - j + 1);
      CharFirst := Ada.Characters.Handling.To_Lower(CharFirst);
      CharLast  := Ada.Characters.Handling.To_Lower(CharLast);
      if CharFirst /= CharLast then
        return False;
      end if;
    end loop;

    return True;
  end;

  procedure test_is_palindrome(Str: String) is
    Result : Boolean := False;
  begin
    Result := is_palindrome(Ada.Strings.Unbounded.To_Unbounded_String(Str));
    if Result = True then
      Ada.Text_IO.Put_Line(Str & ASCII.HT & ASCII.HT & " is palindrome");
    else
      Ada.Text_IO.Put_Line(Str & ASCII.HT & ASCII.HT & " is NOT a palindrome");
    end if;
  end test_is_palindrome;

begin
  test_is_palindrome("a");
  test_is_palindrome("aa");
  test_is_palindrome("aba");
  test_is_palindrome("abba");
  test_is_palindrome("ab");
  test_is_palindrome("abc");
  test_is_palindrome("abca");
  test_is_palindrome("Aba");
  test_is_palindrome("RaceCar");
  test_is_palindrome(" ");
  test_is_palindrome("  ");
  test_is_palindrome("a b a");
  test_is_palindrome("@#@");
  test_is_palindrome("@#a#@");
  test_is_palindrome("ab!!ca");
  test_is_palindrome("");
end palindrome;

