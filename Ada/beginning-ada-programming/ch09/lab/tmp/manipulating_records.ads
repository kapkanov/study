package Manipulating_Records is
  function Index_Of_Substring(Source, Pattern : in String) return Natural;
  function Delete_All_Occurences(Source, Pattern : in String) return String;
  function Concatenate(One, Two : in String) return String;
  function Count_Occurences(Source, Pattern : in String) return Natural;
end Manipulating_Records;

