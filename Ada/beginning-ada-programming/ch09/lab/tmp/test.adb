with Ada.Text_IO;
with Manipulating_Records;


procedure Test is

  function Trim(Str : in String) return String is
  begin
    for j in Str'Range loop
      if Str(j) /= ' ' then
        return Str(j .. Str'Last);
      end if;
    end loop;

    return Str;
  end Trim;

  procedure Index_of_Substring(
    Expected : in Natural; Source, Pattern : in String) is
    Actual : constant Natural := Manipulating_Records.Index_Of_Substring(Source, Pattern);
  begin
    Ada.Text_IO.Put(Boolean'Image(Expected = Actual));
    Ada.Text_IO.Put(
      " Actual = " & Trim(Actual'Image)
      & ", Expected = " & Trim(Expected'Image)
      & ", Source = """ & Source
      & """, Pattern = """ & Pattern & """"
    );
    Ada.Text_IO.New_Line;
  end Index_of_Substring;

begin
  -- Match at a Start
  Index_of_Substring(
    Expected => 1,
    Source   => "Hello World",
    Pattern  => "Hello"
  );

  -- Match in the Middle
  Index_of_Substring(
    Expected => 4,
    Source   => "Hello World",
    Pattern  => "lo W"
  );

  -- Match at the End
  Index_of_Substring(
    Expected => 7,
    Source   => "Hello World",
    Pattern  => "World"
  );

  -- Empty substring
  Index_of_Substring(
    Expected => 1,
    Source   => "Hello World",
    Pattern  => ""
  );

  -- Empty Main string (Non-empty Pattern)
  Index_of_Substring(
    Expected => 0,
    Source   => "",
    Pattern  => "ABC"
  );

  -- Both Empty
  Index_of_Substring(
    Expected => 1,
    Source   => "",
    Pattern  => ""
  );

  -- Substring Longer than Main string
  Index_of_Substring(
    Expected => 0,
    Source   => "Short",
    Pattern  => "LongerString"
  );

  -- Exact Length Match
  Index_of_Substring(
    Expected => 1,
    Source   => "Match",
    Pattern  => "Match"
  );

  -- Substring Length = Main string Length - 1
  Index_of_Substring(
    Expected => 1,
    Source   => "ABC",
    Pattern  => "AB"
  );

  -- Substring Length = Main string Length - 1
  Index_of_Substring(
    Expected => 2,
    Source   => "ABC",
    Pattern  => "BC"
  );

  -- Prefix match only
  Index_of_Substring(
    Expected => 0,
    Source   => "ABCDE",
    Pattern  => "ABF"
  );

  -- Reset Trap
  Index_of_Substring(
    Expected => 4,
    Source   => "AABAACA",
    Pattern  => "AACA"
  );

  -- Repeated Characters. Standard Trap
  Index_of_Substring(
    Expected => 3,
    Source   => "AAAAAB",
    Pattern  => "AAAB"
  );

  -- Distinct Occurrences
  Index_of_Substring(
    Expected => 3,
    Source   => "banana",
    Pattern  => "na"
  );

  -- Overlapping Occurrences
  Index_of_Substring(
    Expected => 1,
    Source   => "abababa",
    Pattern  => "aba"
  );

  -- Whitespace handling
  Index_of_Substring(
    Expected => 1,
    Source   => "   ",
    Pattern  => " "
  );

  -- Tab vs Space
  Index_of_Substring(
    Expected => 0,
    Source   => "A B",
    Pattern  => "A" & ASCII.HT & "B"
  );

  -- Case Sensitivity
  Index_of_Substring(
    Expected => 0,
    Source   => "Hello",
    Pattern  => "hello"
  );

  -- Unicode
  Index_of_Substring(
    Expected => 2,
    Source   => "Héllo",
    Pattern  => "él"
  );
end Test;

