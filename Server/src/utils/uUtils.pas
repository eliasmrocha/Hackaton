unit uUtils;

interface

uses Classes, System.SysUtils, Windows;

function PadWithZeros(const Value: String; PadLength: Integer): String;

implementation

function PadWithZeros(const Value: String; PadLength: Integer): String;
begin
  result := StringOfChar('0', PadLength - Length(Value)) + Value;
end;

end.
