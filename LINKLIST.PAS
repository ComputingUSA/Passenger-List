{Peter Ungsunan                                                             }
{This program is a database of passengers and their tickets for airlines'   }
{seats. It allows you to read in, print, delete, insert, and view passenger }
{lists.                                                                     }

PROGRAM LinkList;                                                   {Heading}
 Uses CRT;                                                     {Declarations}
 Type S1 = Array[1..19] of Char;
      PP = ^PN;
      PN = Record
       Name: S1;
       Class:Char;
       Num:Integer;
       Link:PP;
      End;
 Var A:Char;
     List,Start:PP;

 Procedure Get(Var It,Start:PP);                    {Reads in from disk file}
  Var I:Integer;
      f:Text;
      Nxt:PP;
  Begin
   Assign(f,'c:\LinkList.dat');
   Reset(f);
   New(Nxt);
   Start:=Nxt;
   While Not EOF(f) do                                         {Pointer loop}
    Begin
     It:=Nxt;
     For I:=1 to 19 do
      Read(f,It^.Name[I]);
     Read(f,It^.Class);
     Readln(f,It^.Num);
     New(Nxt);
     It^.Link:=Nxt;
    End;
   It^.Link:=Nil;
   Close(f);
  End;

 Procedure Pri(Var It,Start:PP);                     {Writes list to display}
  Var I:Integer;
  Begin
   ClrScr;
   It:=Start;
   Writeln('Name/ Class/# of seats');
   While It<>Nil do
    Begin
     For I:=1 to 19 do
      Write(It^.Name[I]);
     Write(It^.Class,' ');
     Writeln(It^.Num);
     It:=It^.Link;
    End;
   Repeat Until KeyPressed;                                           {Pause}
  End;

 Procedure Del(Var It,Start:PP);                       {Delete a list record}
  Var I:Integer;
      B:array[0..19] of Char;
      C:Char;
      Pre:PP;
      Q:Boolean;
  Begin
   ClrScr;
   Write('Name to delete from list: ');               {Read in from keyboard}
   For I:=1 to 19 do
    B[I]:=' ';
   I:=0;
   Repeat
    B[I]:=C;
    I:=I+1;
    C:=Readkey;
    Write(C);
   Until ((C=Chr(13)) or (I=19));           {Stop reading when Enter pressed}
   Writeln;
   It:=Start;
   Pre:=Nil;
   Q:=False;
   While ((It<>Nil)and(Not Q)) do                           {Search for name}
    Begin
     Q:=True;
     For I:=1 to 19 do                                   {Compare array loop}
      Q:=((It^.Name[I]=B[I]) and Q);
     If Not Q then                                            {Q = Not Found}
      Begin
       Pre:=It;
       It:=It^.Link;
      End;
    End;
   If Q then
    Begin
     If (Pre=Nil) then Start:=It^.Link                          {Delete Node}
      else Pre^.Link:=It^.Link;                                    {if found}
     Writeln('Deleted.');
    End
    else Writeln('Name not found.');
    C:=Readkey;
   End;

 Procedure Ins(Var It,Start:PP);                {Inserts node at end of list}
  Var I:Integer;
      B:array[0..19] of Char;
      C:Char;
      Pre,Nxt:PP;
      Q:Boolean;
  Begin
   ClrScr;
   Write('Name to insert: ');                                  {Ask for info}
   For I:=1 to 19 do
    B[I]:=' ';
   I:=0;
   Repeat
    B[I]:=C;
    I:=I+1;
    C:=Readkey;
    Write(C);
   Until ((C=Chr(13)) or (I=19));
   Writeln;
   Write('Class: ');
   Readln(C);
   Write('Number of seats: ');
   Readln(I);
   It:=Start;
   While It^.Link<>Nil do                                    {Get to the end}
    It:=It^.Link;
   New(Nxt);                                              {Attach new record}
   It^.Link:=Nxt;
   Nxt^.Link:=Nil;
   Nxt^.Num:=I;
   Nxt^.Class:=C;
   For I:=1 to 19 do
    Nxt^.Name[I]:=B[I];
   Writeln('Inserted.');
   C:=Readkey;
  End;

 Procedure Ret(Var It,Start:PP);        {Search for a node and show contents}
  Var I:Integer;
      B:array[0..19] of Char;
      C:Char;
      Pre:PP;
      Q:Boolean;
  Begin
   ClrScr;
   Write('Name to locate: ');                  {Same search routine as above}
   For I:=1 to 19 do
    B[I]:=' ';
   I:=0;
   Repeat
    B[I]:=C;
    I:=I+1;
    C:=Readkey;
    Write(C);
   Until ((C=Chr(13)) or (I=19));
   Writeln;
   It:=Start;
   Q:=False;
   While ((It<>Nil)and(Not Q)) do
    Begin
     Q:=True;
     For I:=1 to 19 do
      Q:=((It^.Name[I]=B[I]) and Q);
     If Not Q then
       It:=It^.Link;
    End;
   If Q then
    Begin
     Writeln('Name/ Class/# of seats');         {Same Print routine as above}
     For I:=1 to 19 do
      Write(It^.Name[I]);
     Write(It^.Class,' ');
     Writeln(It^.Num);
    End
    else Writeln('Name not found.');
    C:=Readkey;
   End;

Begin
Start:=List;
Repeat
 ClrScr;                                                         {Write Menu}
 Writeln('[1] Read the passenger list from the file');
 Writeln('[2] Print the passenger list');
 Writeln('[3] Delete a passenger from the list');
 Writeln('[4] Insert a passenger into the list');
 Writeln('[5] Get the information on a passenger');
 Writeln('[Esc] Exit');
 Write('Choose [1-7]');
 Repeat A:=ReadKey                                    {Wait for # or Esc Key}
  Until A In['1','2','3','4','5',Chr(27)];
 Case A of                                        {Call respective Procedure}
 '1':Get(List,Start);
 '2':Pri(List,Start);
 '3':Del(List,Start);
 '4':Ins(List,Start);
 '5':Ret(List,Start);
 End;
Until A=Chr(27);                                             {Exit Condition}
End.

I. Data Structures
 A. File
 B. Linked List of records

II. Tree Diagram
                          Menu
                            |
          +-----+-------+---+------+--------+
          |     |       |          |        |
        Read  Print   Delete    Insert  Search/View

III. Output