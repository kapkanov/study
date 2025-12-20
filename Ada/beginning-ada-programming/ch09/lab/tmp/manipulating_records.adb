with Ada.Text_IO;



package body Manipulating_Records is


  function Count_Occurences(Source, Pattern : in String)
    return Natural is
    Count : Natural := 0;
    Index : Natural := Index_Of_Substring(Source, Pattern);
  begin
    if Pattern'Length = 0 then
      return 0;
    end if;

    while Index /= 0 loop
      Count := Count + 1;
      Index := Index_Of_Substring(
        Source(Index + Pattern'Length .. Source'Last),
        Pattern
      );
    end loop;

    return Count;
  end Count_Occurences;


  function Index_Of_Substring(Source, Pattern : in String)
    return Natural is
    Index_Main    : Natural := Source'First;
    Index_Next    : Natural := Source'First;
    Index_Sub     : Natural := Pattern'First;
    Result        : Natural := 0;
  begin
    if Pattern'Length = 0 then
      return Source'First;
    end if;

    if Source'Length = 0 then
      return 0;
    end if;

    loop
      exit when 
        Source'Last - Index_Main
        < Pattern'Last - Index_Sub;
      if Source(Index_Main) /= Pattern(Index_Sub) then
        exit when Index_Main = Source'Last;
        Index_Main := Index_Next;
        Index_Sub  := Pattern'First;
        if Index_Next /= Source'Last then
          Index_Next := Index_Next + 1;
        end if;
        goto Continue;
      end if;
      if Index_Sub = Pattern'Last then
        Result := (
          if Index_Next = Source'First then Index_Next else Index_Next - 1
      );
        exit;
      end if;
      Index_Main := Index_Main + 1;
      Index_Sub  := Index_Sub  + 1;
      <<Continue>>
    end loop;

    return Result;
  end Index_Of_Substring;


  function Concatenate(One, Two : in String) return String is
    Result : String(1 .. One'Length + Two'Length);
  begin
    Result(Result'First              .. Result'First + One'Length - 1) := One;
    Result(Result'First + One'Length .. Result'Last)                   := Two;

    return Result;
  end Concatenate;


  function Delete_All_Occurences(Source, Pattern : in String)
    return String is
    Result        : String(1 .. Source'Length);
    Index_Result  : Natural := Result'First;
    Index_Pattern : Natural := Pattern'First;
  begin
    if Pattern'Length = 0 or Pattern'Length > Source'Length then
      Result := Source;
      return Result;
    end if;

    for c of Source loop
      Result(Index_Result) := c;
      if c = Pattern(Index_Pattern) then
        if Index_Pattern = Pattern'Last then
          Index_Pattern := Pattern'First;
          Index_Result  := Index_Result - Pattern'Length;
        else
          Index_Pattern := Index_Pattern + 1;
        end if;
      end if;
      Index_Result := Index_Result + 1;
    end loop;

    return Result(Result'First .. Index_Result - 1);
  end Delete_All_Occurences;


end Manipulating_Records;

