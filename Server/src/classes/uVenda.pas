unit uVenda;

interface

uses
  System.JSON, System.SysUtils, uUsuario, FireDAC.Comp.Client;

type
  TVenda = class
  private
    FConexao: TFDConnection;
    FCNPJ_Estabelecimento: string;
    FIdCliente: string;

    procedure TrataUsuario;
    procedure TrataVenda;
    { Private Declarations }
  public
    //M�todos p�blicos
    constructor Create(AConexao: TFDConnection);
    procedure CadastraVenda;

    procedure Assign(AJSON : TJSONObject);

    //Propriedades
    property IdCliente            : string read FIdCliente            write FIdCliente;
    property CNPJ_Estabelecimento : string read FCNPJ_Estabelecimento write FCNPJ_Estabelecimento;
    { Public Declarations }
  end;

implementation

{ TVenda }

procedure TVenda.Assign(AJSON: TJSONObject);
begin
  FIdCliente            := AJSON.GetValue('id_cliente').Value;
  FCNPJ_Estabelecimento := AJSON.GetValue('cnpj').Value;
end;

procedure TVenda.TrataUsuario;
var
  LUsuario: TUsuario;
begin
  LUsuario := TUsuario.Create(FConexao);
  try
    //Caso tenha um @ na mensagem, o email foi preenchido
    if Pos('@', FIdCliente) <> 0 then
    begin
      LUsuario.EMail := FIdCliente;
      LUsuario.LocalizaUsuarioPorEmail(FIdCliente);
    end;
  finally
    LUsuario.Free;
  end;
end;

procedure TVenda.TrataVenda;
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(FConexao);
  try
    try
//      LQuery.Connection := FConexao;
//
//      LQuery.SQL.Clear;
//      LQuery.SQL.Add('insert into venda (');
//      LQuery.SQL.Add('  id      ');
//      LQuery.SQL.Add(') values (');
//      LQuery.SQL.Add('  :id     ');
//      LQuery.SQL.Add(')');
//
//      LQuery.ParamByName('id').AsInteger := StrToInt(FIdCliente);
//      LQuery.ExecSQL();
    except
      raise Exception.Create('ERRO AO CADASTRAR VENDA');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TVenda.CadastraVenda;
begin
  TrataUsuario;
  TrataVenda;
end;

constructor TVenda.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao
end;

end.
