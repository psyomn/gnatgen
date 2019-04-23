with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with GnatGen; use GnatGen;
with Argument_Stack;

package body Actions.Func is

  procedure Help is
  begin
    Put_Line("  (func|function) name:return_type [parameter:type]* - Print the generated function");
  end Help;

  function Try_Act return Boolean is
    Func : Parameter;
  begin
    if Argument_Stack.Is_Empty then goto Fail; end if;
    declare
      Action : constant String := Argument_Stack.Pop;
    begin
      if To_Upper(Action) /= "FUNC" and To_Upper(Action) /= "FUNCTION" then
        goto Fail;
      end if;
    end;
    if Argument_Stack.Is_Empty then
      Put_Line(Standard_Error, "Error: No function signature was specified");
      goto Fail;
    end if;
    if not Try_Parse(Argument_Stack.Pop, Func) then
      Put_Line(Standard_Error, "Error: The function signature was invalid");
      goto Fail;
    end if;
    if Argument_Stack.Is_Empty then
      Print_Function(Func);
    else
      declare
        Params : Parameter_Array(1 .. Argument_Stack.Length);
      begin
        for I in 1 .. Argument_Stack.Length loop
          if not Try_Parse(Argument_Stack.Pop, Params(I)) then
            Argument_Stack.Push_Back;
            Put_Line(Standard_Error, "Error: The parameter signature """ & Argument_Stack.Pop & """ was invalid");
            goto Fail;
          end if;
        end loop;
        Print_Function(Func, Params);
      end;
    end if;
    return True;
    <<Fail>>
    Argument_Stack.Reset;
    return False;
  end Try_Act;

end Actions.Func;