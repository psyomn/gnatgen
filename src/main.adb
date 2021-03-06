-- Copyright 2014-2019 Simon Symeonidis (psyomn)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--   http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

with Ada.Text_IO; use Ada.Text_IO;
with Actions.Comment;
with Actions.Func;
with Actions.Init;
with Actions.Proc;

-- Entry point for this command line application.
procedure Main is
   Success : Boolean := False;
begin
   if not Success then
      Success := Actions.Comment.Try_Act;
   end if;
   if not Success then
      Success := Actions.Func.Try_Act;
   end if;
   if not Success then
      Success := Actions.Init.Try_Act;
   end if;
   if not Success then
      Success := Actions.Proc.Try_Act;
   end if;
   if not Success then --Whatever was entered wasn't understood, so print all the help
      -- Part of the beauty of this approach is it handles --help for us without any code
      Actions.Comment.Help;
      Actions.Func.Help;
      Actions.Init.Help;
      Actions.Proc.Help;
   end if;
exception
   when others =>
      Put_Line("Looks like something bad happened. Please consider filing a bug report, including the command you wrote, and the exception that printed out, to https://github.com/psyomn/agen/issues");
      raise;
end Main;
