unit HKCriptoSenha;

interface

uses
  Controls, SysUtils, StrUtils;

const
  AlfabetoEncriptado = '6JbcG2zABawQRopSZsnE1qrF7XdeUCOuhijT5VYWKLMxy8HD9fg0lmNkIP34vt';
  AlfabetoCorreto    = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

type
  TCripto = class
  private
  public
    function Encripta_Senha(Key: String): String;
    function Preenche_Zeros(I: Integer): String;
    function Decripta_Senha(Key: String): String;
      { Public declarations }
  private
      { Priovate declarations }
  end;

implementation

{ TCripto }

function TCripto.Decripta_Senha(Key: String): String;
var
  SenhaDecriptada, VarLocal: String;
  Cont, TamKey, TamReal: Integer;
  I: Integer;
begin
  TamKey := Length(Key);
  TamReal := Length(AlfabetoCorreto);

  SenhaDecriptada := EmptyStr;

  for Cont := 1 to TamKey do
  begin
    VarLocal := Copy(Key,Cont,1);

    for I := 1 to TamReal do
    begin
      if VarLocal = Copy(AlfabetoEncriptado, I, 1) then
      begin
        SenhaDecriptada := SenhaDecriptada + Copy(AlfabetoCorreto, I, 1);
      end;
    end;
  end;

  Result := SenhaDecriptada;
end;

function TCripto.Encripta_Senha(Key: String): String;
var
  SenhaEncriptada, VarLocal: String;
  Cont, TamKey, TamReal: Integer;
  I: Integer;
begin
  TamKey  := Length(Key);
  TamReal := Length(AlfabetoCorreto);

  SenhaEncriptada := EmptyStr;

  for Cont := 1 to TamKey do
  begin
    VarLocal := Copy(Key,Cont,1);

    for I := 1 to TamReal do
    begin
      if VarLocal = Copy(AlfabetoCorreto, I, 1) then
      begin
        SenhaEncriptada := SenhaEncriptada + Copy(AlfabetoEncriptado, I, 1);
      end;
    end;
  end;

  Result := SenhaEncriptada;
end;

function TCripto.Preenche_Zeros(I: Integer): String;
begin
  if (I >= 0) and (I <= 9) then
    Result := '00' + IntToStr(I);

  if (I >= 10) and (I <= 99) then
    Result := '0' + IntToStr(I);

  if (I >= 100) and (I <= 999) then
    Result := IntToStr(I);
end;

end.
