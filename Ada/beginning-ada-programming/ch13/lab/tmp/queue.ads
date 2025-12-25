generic
  Size : Positive;
  type T is private;
package Queue is
  procedure Push(Element : T);
  function  Pop return T;
  -- function  Length return Natural;
end Queue;

