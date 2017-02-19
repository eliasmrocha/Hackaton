unit HKCripto;

interface

uses
  SysUtils, Classes, HKConst_Alfabeto, uUtils;

function EncriptPassword(ASenha: string): string;
function DecriptPassword(AKey: string): string;

implementation

function GetAlfabetoEncriptado(AAlfabetoId: Integer): string;
begin
  case AAlfabetoId of
    01: Result := Alfabeto_01;
    02: Result := Alfabeto_02;
    03: Result := Alfabeto_03;
    04: Result := Alfabeto_04;
    05: Result := Alfabeto_05;
    06: Result := Alfabeto_06;
    07: Result := Alfabeto_07;
    08: Result := Alfabeto_08;
    09: Result := Alfabeto_09;
    10: Result := Alfabeto_10;

    11: Result := Alfabeto_11;
    12: Result := Alfabeto_12;
    13: Result := Alfabeto_13;
    14: Result := Alfabeto_14;
    15: Result := Alfabeto_15;
    16: Result := Alfabeto_16;
    17: Result := Alfabeto_17;
    18: Result := Alfabeto_18;
    19: Result := Alfabeto_19;
    20: Result := Alfabeto_20;

    21: Result := Alfabeto_21;
    22: Result := Alfabeto_22;
    23: Result := Alfabeto_23;
    24: Result := Alfabeto_24;
    25: Result := Alfabeto_25;
    26: Result := Alfabeto_26;
    27: Result := Alfabeto_27;
    28: Result := Alfabeto_28;
    29: Result := Alfabeto_29;
    30: Result := Alfabeto_30;

    31: Result := Alfabeto_31;
    32: Result := Alfabeto_32;
    33: Result := Alfabeto_33;
    34: Result := Alfabeto_34;
    35: Result := Alfabeto_35;
    36: Result := Alfabeto_36;
    37: Result := Alfabeto_37;
    38: Result := Alfabeto_38;
    39: Result := Alfabeto_39;
    40: Result := Alfabeto_40;

    41: Result := Alfabeto_41;
    42: Result := Alfabeto_42;
    43: Result := Alfabeto_43;
    44: Result := Alfabeto_44;
    45: Result := Alfabeto_45;
    46: Result := Alfabeto_46;
    47: Result := Alfabeto_47;
    48: Result := Alfabeto_48;
    49: Result := Alfabeto_49;
    50: Result := Alfabeto_50;

    51: Result := Alfabeto_51;
    52: Result := Alfabeto_52;
    53: Result := Alfabeto_53;
    54: Result := Alfabeto_54;
    55: Result := Alfabeto_55;
    56: Result := Alfabeto_56;
    57: Result := Alfabeto_57;
    58: Result := Alfabeto_58;
    59: Result := Alfabeto_59;
    60: Result := Alfabeto_60;
  end;
end;

function GenerateRandomValue(PMaxValue: Integer = 60): Integer;
var
  LVal: Integer;
begin
  Randomize;
  LVal := Random(1024);
  LVal := ((LVal div 6) * 50) div 4;

  repeat
    LVal := LVal div 2;
  until LVal <= PMaxValue;

  if LVal = 0 then
  begin
    Randomize;
    LVal := Random(PMaxValue);
  end;

  Result := LVal;
end;

function EncriptPassword(ASenha: string): string;
var
  LSenhaEncriptada: string;
  LNumeroNormalIniPar, LNumeroNormalFimImpar: String;
  LAlfabetoPar, LAlfabetoImpar: string;
  LNumeracaoIniParEncriptada: string;
  LNumeracaoFimImparEncriptada: string;
  I, X, LValIni_Par, LValFim_Impar, LTamanho: Integer;
  LFoundChar: Boolean;
begin
  LSenhaEncriptada := EmptyStr;
  LAlfabetoPar     := EmptyStr;
  LAlfabetoImpar   := EmptyStr;

  LTamanho := Length(ASenha);

  if LTamanho > 0 then
  begin
    LValIni_Par   := GenerateRandomValue();
    LValFim_Impar := GenerateRandomValue();

    if LValIni_Par = LValFim_Impar then
    begin
      while LValIni_Par = LValFim_Impar do
      begin
        LValIni_Par   := GenerateRandomValue();
        LValFim_Impar := GenerateRandomValue();
      end;
    end;

    LAlfabetoPar   := GetAlfabetoEncriptado(LValIni_Par);
    LAlfabetoImpar := GetAlfabetoEncriptado(LValFim_Impar);

    LNumeroNormalIniPar   := PadWithZeros(IntToStr(LValIni_Par), 2);
    LNumeroNormalFimImpar := PadWithZeros(IntToStr(LValFim_Impar), 2);

    //Encriptação de Senha
    for X := 1 to LTamanho do
    begin
      LFoundChar := False;
      for I := 1 to Length(Alfabeto_Co) do
      begin
        if Copy(Alfabeto_Co, I, 1) = Copy(ASenha, X, 1) then
        begin
          LFoundChar := True;
          if (X mod 2) = 0 then
            LSenhaEncriptada := LSenhaEncriptada + Copy(LAlfabetoPar, I, 1)
          else
            LSenhaEncriptada := LSenhaEncriptada + Copy(LAlfabetoImpar, I, 1);
        end;
      end;
      if not LFoundChar then
        raise Exception.CreateFmt('Caracter não mapeado na criptografia J2V: %s', [Copy(ASenha, X, 1)]);
    end;

    //Encriptação da numeração inicial (Par)
    for X := 1 to 2 do
    begin
      for I := 1 to 10 do
      begin
        if Copy(Numeracao_co, I, 1) = Copy(LNumeroNormalIniPar, X, 1) then
          LNumeracaoIniParEncriptada := LNumeracaoIniParEncriptada + Copy(Numeracao_errada, I, 1);
      end;
    end;

    //Encriptação da numeração final (Impar)
    for X := 1 to 2 do
    begin
      for I := 1 to 10 do
      begin
        if Copy(Numeracao_co, I, 1) = Copy(LNumeroNormalFimImpar, X, 1) then
          LNumeracaoFimImparEncriptada := LNumeracaoFimImparEncriptada + Copy(Numeracao_errada, I, 1);
      end;
    end;

    LSenhaEncriptada := LNumeracaoIniParEncriptada + LSenhaEncriptada + LNumeracaoFimImparEncriptada;

    Result := LSenhaEncriptada;
  end
  else
    Result := ERRO_SENHA;
end;

function DecriptPassword(AKey: string): string;
var
  LNumeracaoIniPar, LNumeracaoFimImpar: String;
  LTamanho, X, I: Integer;
  LAlfabetoIniPar, LAlfabetoFimImpar: string;
  LSenhaEncriptada: String;
  LSenhaDecriptada: String;
  LNumeracaoIniParDecript: string;
  LNumeracaoFimImparDecript: string;
  LFoundChar: Boolean;
begin
  //Subtrai a numeração do início (2) e do fim (2)
  LTamanho := Length(AKey) - 4;

  if LTamanho > 0 then
  begin
    LSenhaEncriptada := Copy(AKey, 3, LTamanho);

    LNumeracaoIniPar   := Copy(AKey, 1, 2);
    LNumeracaoFimImpar := Copy(AKey, (Length(AKey) - 1), 2);

    //Descriptografia da Numeração Inicial (Par)
    for X := 1 to 2 do
    begin
      for I := 1 to 10 do
      begin
        if Copy(Numeracao_errada, I, 1) = Copy(LNumeracaoIniPar, X, 1) then
        begin
          LNumeracaoIniParDecript := LNumeracaoIniParDecript + Copy(Numeracao_co, I, 1);
          Break;
        end;
      end;
    end;

    //Descriptografia da Numeração Final (Impar)
    for X := 1 to 2 do
    begin
      for I := 1 to 10 do
      begin
        if Copy(Numeracao_errada, I, 1) = Copy(LNumeracaoFimImpar, X, 1) then
        begin
          LNumeracaoFimImparDecript := LNumeracaoFimImparDecript + Copy(Numeracao_co, I, 1);
          Break;
        end;
      end;
    end;

    if (Length(LNumeracaoIniParDecript)   <> 2) or
       (Length(LNumeracaoFimImparDecript) <> 2) then
    begin
      Result := ERRO_SENHA;
      Exit;
    end;

    LAlfabetoIniPar   := GetAlfabetoEncriptado(StrToInt(LNumeracaoIniParDecript));
    LAlfabetoFimImpar := GetAlfabetoEncriptado(StrToInt(LNumeracaoFimImparDecript));


    for X := 1 to LTamanho do
    begin
      LFoundChar := False;
      for I := 1 to Length(Alfabeto_Co) do
      begin
        if (X mod 2) = 0 then
        begin
          if Copy(LAlfabetoIniPar, I, 1) = Copy(LSenhaEncriptada, X, 1) then
          begin
            LFoundChar := True;
            LSenhaDecriptada := LSenhaDecriptada + Copy(Alfabeto_Co, I, 1);
            Break;
          end;
        end
        else
        begin
          if Copy(LAlfabetoFimImpar, I, 1) = Copy(LSenhaEncriptada, X, 1) then
          begin
            LFoundChar := True;
            LSenhaDecriptada := LSenhaDecriptada + Copy(Alfabeto_Co, I, 1);
            Break;
          end;
        end;
      end;
      if not LFoundChar then
        raise Exception.CreateFmt('Caracter não mapeado na criptografia J2V: %s', [Copy(LSenhaEncriptada, X, 1)]);
    end;

    Result := LSenhaDecriptada;
  end
  else
    Result := ERRO_SENHA;
end;

function isTheSamePassword(ASenhaEncriptada, ASenhaDecriptada: string): Boolean;
begin
  if Length(ASenhaEncriptada) <= 4 then
    Result := False
  else
    Result := ASenhaDecriptada = DecriptPassword(ASenhaEncriptada);
end;

end.


