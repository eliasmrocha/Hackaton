unit uVenda;

interface

uses
  System.JSON, System.SysUtils, uUsuario, FireDAC.Comp.Client, uEstabelecimento,
  FireDAC.DApt;

type
  TVenda = class
  private
    FConexao: TFDConnection;
    FEstabelecimento: TEstabelecimento;
    FUsuario: TUsuario;

    procedure TrataUsuario;
    procedure TrataVenda;
    { Private Declarations }
  public
    //M�todos p�blicos
    constructor Create(AConexao: TFDConnection);
    destructor Destroy; override;

    procedure CadastraVenda;

    procedure Assign(AJSON : TJSONObject);

    //Propriedades
    property Usuario        : TUsuario         read FUsuario         write FUsuario;
    property Estabelecimento: TEstabelecimento read FEstabelecimento write FEstabelecimento;
    { Public Declarations }
  end;

implementation

{ TVenda }

procedure TVenda.Assign(AJSON: TJSONObject);
var
  LIdCliente: string;
begin
  LIdCliente := AJSON.GetValue('id_cliente').Value;

  if Pos('@', LIdCliente) <> 0 then
    FUsuario.EMail := LIdCliente
  else
    FUsuario.CPF := LIdCliente;

  FEstabelecimento.CNPJ := AJSON.GetValue('cnpj').Value;
end;

procedure TVenda.TrataUsuario;
begin
  //Caso tenha um @ na mensagem, o email foi preenchido
  if Trim(FUsuario.EMail) <> '' then
    FUsuario.LocalizaUsuarioPorEmail(FUsuario.EMail);
end;

procedure TVenda.TrataVenda;
var
  LQuery : TFDQuery;
begin
  //Preenche as propriedades do estabelecimento
  FEstabelecimento.LocalizaEstabelecimentoPorCNPJ(FEstabelecimento.CNPJ);

  if FEstabelecimento.Id <> 0 then
  begin
    LQuery := TFDQuery.Create(FConexao);
    try
      try
        LQuery.Connection := FConexao;

        LQuery.SQL.Clear;
        LQuery.SQL.Add('insert into venda (  ');
        LQuery.SQL.Add('  usuario_id,        ');
        LQuery.SQL.Add('  data,              ');
        LQuery.SQL.Add('  estabelecimento_id ');
        LQuery.SQL.Add(') values (');
        LQuery.SQL.Add('  :usuario_id,        ');
        LQuery.SQL.Add('  :data,              ');
        LQuery.SQL.Add('  :estabelecimento_id ');
        LQuery.SQL.Add(')');

        LQuery.ParamByName('usuario_id').AsInteger         := FUsuario.Id;
        LQuery.ParamByName('data').AsDateTime              := Now;
        LQuery.ParamByName('estabelecimento_id').AsInteger := FEstabelecimento.Id;
        LQuery.ExecSQL();
      except
        raise Exception.Create('ERRO AO CADASTRAR VENDA');
      end;
    finally
      FreeAndNil(LQuery);
    end;
  end;
end;

procedure TVenda.CadastraVenda;
begin
  TrataUsuario;
  TrataVenda;
end;

constructor TVenda.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;

  FUsuario         := TUsuario.Create(AConexao);
  FEstabelecimento := TEstabelecimento.Create(AConexao);
end;

destructor TVenda.Destroy;
begin
  FUsuario.Free;
  FEstabelecimento.Free;

  inherited;
end;

end.
