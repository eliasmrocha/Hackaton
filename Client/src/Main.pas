unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.Themes, System.JSON,
  FireDAC.Comp.Client, FireDAC.DApt, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TPublicacaoPropria = class
    Data  : String;
    Texto : String;
  end;

  TPublicacaoAmigos = class
    ID    : String;
    Nome  : String;
    data  : String;
    texto : String;
  end;

  TSugestoesAmigos = class
    ID    : String;
    Nome  : String;
  end;

  TUltimasCompras = class
    EstabelecimentoId : String;
    Nome              : String;
  end;

  TForm1 = class(TForm)
    Panel2: TPanel;
    pnPadLeft: TPanel;
    pnPadTop: TPanel;
    pnContainer: TPanel;
    pnLogo: TPanel;
    Image1: TImage;
    lbl1: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Image2: TImage;
    Panel4: TPanel;
    Image3: TImage;
    Panel5: TPanel;
    Image4: TImage;
    Panel6: TPanel;
    Image5: TImage;
    Image6: TImage;
    Panel7: TPanel;
    Label2: TLabel;
    Panel8: TPanel;
    Image7: TImage;
    Panel9: TPanel;
    Image8: TImage;
    Panel12: TPanel;
    Label3: TLabel;
    Panel13: TPanel;
    Image11: TImage;
    Panel14: TPanel;
    Image12: TImage;
    Panel15: TPanel;
    Image13: TImage;
    Panel16: TPanel;
    Image14: TImage;
    Panel17: TPanel;
    Label4: TLabel;
    Panel18: TPanel;
    Image15: TImage;
    Panel19: TPanel;
    Image16: TImage;
    Panel20: TPanel;
    Image17: TImage;
    Panel21: TPanel;
    Image18: TImage;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    Panel10: TPanel;
    Edit2: TEdit;
    Image9: TImage;
    IdHTTP1: TIdHTTP;
    procedure FormCreate(Sender: TObject);

    procedure BuscarPublicacoesProprias;
    procedure BuscarPublicacoesAmigos;
    procedure BuscarIndicaoesAmigos;
    procedure BuscarUltimasCompras;

    procedure RetornaPublicacoesProprias(AId: Integer);
    procedure Image15Click(Sender: TObject);
    procedure Image16Click(Sender: TObject);
    procedure Image17Click(Sender: TObject);
    procedure Image18Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image14Click(Sender: TObject);
  private
    FID : string;
    FPublicacoProria1 : TPublicacaoPropria;
    FPublicacoProria2 : TPublicacaoPropria;
    FPublicacoProria3 : TPublicacaoPropria;
    FPublicacoProria4 : TPublicacaoPropria;

    FPublicacaoAmigos1 : TPublicacaoAmigos;
    FPublicacaoAmigos2 : TPublicacaoAmigos;
    FPublicacaoAmigos3 : TPublicacaoAmigos;
    FPublicacaoAmigos4 : TPublicacaoAmigos;

    FSugestaoAmizade1 : TSugestoesAmigos;
    FSugestaoAmizade2 : TSugestoesAmigos;

    FUltimasCompras1 : TUltimasCompras;
    FUltimasCompras2 : TUltimasCompras;
    FUltimasCompras3 : TUltimasCompras;
    FUltimasCompras4 : TUltimasCompras;

    function ConsumeJsonBytes(AJsonString: String): TJSONObject;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Login, udmConexao;

procedure TForm1.BuscarIndicaoesAmigos;
begin
  FSugestaoAmizade1 := TSugestoesAmigos.Create;
  FSugestaoAmizade2 := TSugestoesAmigos.Create;

//  SugestoesAmigos
end;

procedure TForm1.BuscarPublicacoesAmigos;
var
  LQuery : TFDQuery;
begin
  FPublicacaoAmigos1 := TPublicacaoAmigos.Create;
  FPublicacaoAmigos2 := TPublicacaoAmigos.Create;
  FPublicacaoAmigos3 := TPublicacaoAmigos.Create;
  FPublicacaoAmigos4 := TPublicacaoAmigos.Create;

  LQuery := TFDQuery.Create(dmConexao.fdConexao);
  try
    try
      LQuery.Connection := dmConexao.fdConexao;

      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT ');
      LQuery.SQL.Add('  ua.usuario_id,');
      LQuery.SQL.Add('  c.nome,');
      LQuery.SQL.Add('  (SELECT');
      LQuery.SQL.Add('      Max(up1.data)');
      LQuery.SQL.Add('    FROM');
      LQuery.SQL.Add('      usuario_publicacao up1');
      LQuery.SQL.Add('    WHERE');
      LQuery.SQL.Add('      up1.usuario_id = ua.amigo_id) AS dat_publicacao,');
      LQuery.SQL.Add('  (SELECT');
      LQuery.SQL.Add('     up.texto');
      LQuery.SQL.Add('   FROM');
      LQuery.SQL.Add('     usuario_publicacao up');
      LQuery.SQL.Add('   WHERE');
      LQuery.SQL.Add('      up.usuario_id = ua.amigo_id');
      LQuery.SQL.Add('      AND up.data = (SELECT Max(up1.data) FROM usuario_publicacao up1 WHERE up1.usuario_id = ua.amigo_id)');
      LQuery.SQL.Add('  ) AS publicacao');
      LQuery.SQL.Add('FROM');
      LQuery.SQL.Add('  usuario_amigo ua');
      LQuery.SQL.Add('  INNER JOIN usuario u ON (ua.amigo_id = u.id)');
      LQuery.SQL.Add('  INNER JOIN cliente c ON (c.id = u.id)');
      LQuery.SQL.Add('WHERE');
      LQuery.SQL.Add('  ua.usuario_id = :id');
      LQuery.SQL.Add('ORDER BY');
      LQuery.SQL.Add('  c.nome');

      LQuery.ParamByName('id').AsInteger := StrToInt(FId);
      LQuery.Open();


      FPublicacaoAmigos1.ID    := LQuery.FieldByName('usuario_id').AsString;
      FPublicacaoAmigos1.Nome  := LQuery.FieldByName('nome').AsString;
      FPublicacaoAmigos1.data  := LQuery.FieldByName('dat_publicacao').AsString;
      FPublicacaoAmigos1.texto := LQuery.FieldByName('publicacao').AsString;
      LQuery.Next;

      FPublicacaoAmigos2.ID    := LQuery.FieldByName('usuario_id').AsString;
      FPublicacaoAmigos2.Nome  := LQuery.FieldByName('nome').AsString;
      FPublicacaoAmigos2.data  := LQuery.FieldByName('dat_publicacao').AsString;
      FPublicacaoAmigos2.texto := LQuery.FieldByName('publicacao').AsString;
      LQuery.Next;

      FPublicacaoAmigos3.ID    := LQuery.FieldByName('usuario_id').AsString;
      FPublicacaoAmigos3.Nome  := LQuery.FieldByName('nome').AsString;
      FPublicacaoAmigos3.data  := LQuery.FieldByName('dat_publicacao').AsString;
      FPublicacaoAmigos3.texto := LQuery.FieldByName('publicacao').AsString;
      LQuery.Next;

      FPublicacaoAmigos4.ID    := LQuery.FieldByName('usuario_id').AsString;
      FPublicacaoAmigos4.Nome  := LQuery.FieldByName('nome').AsString;
      FPublicacaoAmigos4.data  := LQuery.FieldByName('dat_publicacao').AsString;
      FPublicacaoAmigos4.texto := LQuery.FieldByName('publicacao').AsString;
      LQuery.Next;
    except
      on E: Exception do
        raise Exception.Create('ERRO AO CONSULTAR AS PUBLICAÇÕES DOS AMIGOS DO USUARIO');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TForm1.BuscarPublicacoesProprias;
begin
  FPublicacoProria1 := TPublicacaoPropria.Create;
  FPublicacoProria2 := TPublicacaoPropria.Create;
  FPublicacoProria3 := TPublicacaoPropria.Create;
  FPublicacoProria4 := TPublicacaoPropria.Create;

  RetornaPublicacoesProprias(StrToInt(FId));

end;

procedure TForm1.BuscarUltimasCompras;
begin
  FUltimasCompras1 := TUltimasCompras.Create;
  FUltimasCompras2 := TUltimasCompras.Create;
  FUltimasCompras3 := TUltimasCompras.Create;
  FUltimasCompras4 := TUltimasCompras.Create;

//  UltimasCompras
end;

function TForm1.ConsumeJsonBytes(AJsonString: String): TJSONObject;
begin
  Result := nil;
  Result := TJsonObject.Create;
  Result.Parse(BytesOf(AJsonString), 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Fid := '16';
  dmconexao.ConectaDB;
  BuscarPublicacoesProprias;
  BuscarPublicacoesAmigos;
  BuscarIndicaoesAmigos;
  BuscarUltimasCompras;
end;

procedure TForm1.Image11Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacaoAmigos1.Nome + sLineBreak + FPublicacaoAmigos1.data;
  RichEdit2.Text := FPublicacaoAmigos1.Texto;
end;

procedure TForm1.Image12Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacaoAmigos2.Nome + sLineBreak + FPublicacaoAmigos2.data;
  RichEdit2.Text := FPublicacaoAmigos2.Texto;
end;

procedure TForm1.Image13Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacaoAmigos3.Nome + sLineBreak + FPublicacaoAmigos3.data;
  RichEdit2.Text := FPublicacaoAmigos3.Texto;
end;

procedure TForm1.Image14Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacaoAmigos4.Nome + sLineBreak + FPublicacaoAmigos4.data;
  RichEdit2.Text := FPublicacaoAmigos4.Texto;

end;

procedure TForm1.Image15Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacoProria1.Data;
  RichEdit2.Text := FPublicacoProria1.Texto;
end;

procedure TForm1.Image16Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacoProria2.Data;
  RichEdit2.Text := FPublicacoProria2.Texto;

end;

procedure TForm1.Image17Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacoProria3.Data;
  RichEdit2.Text := FPublicacoProria3.Texto;
end;

procedure TForm1.Image18Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
  RichEdit1.Text := FPublicacoProria4.Data;
  RichEdit2.Text := FPublicacoProria4.Texto;
end;

procedure TForm1.RetornaPublicacoesProprias(AId: Integer);
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(dmConexao.fdConexao);
  try
    try
      LQuery.Connection := dmConexao.fdConexao;

      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT                  ');
      LQuery.SQL.Add('  up.data,              ');
      LQuery.SQL.Add('  up.texto              ');
      LQuery.SQL.Add('FROM                    ');
      LQuery.SQL.Add('  usuario_publicacao up ');
      LQuery.SQL.Add('WHERE                   ');
      LQuery.SQL.Add('  up.usuario_id = :id   ');
      LQuery.SQL.Add('  and ROWNUM <= 4       ');

      LQuery.ParamByName('id').AsInteger := AId;
      LQuery.Open();

      FPublicacoProria1.Data  := LQuery.FieldByName('DATA').AsString;
      FPublicacoProria1.Texto := LQuery.FieldByName('TEXTO').AsString;
      LQuery.Next;

      FPublicacoProria2.Data  := LQuery.FieldByName('DATA').AsString;
      FPublicacoProria2.Texto := LQuery.FieldByName('TEXTO').AsString;
      LQuery.Next;

      FPublicacoProria3.Data  := LQuery.FieldByName('DATA').AsString;
      FPublicacoProria3.Texto := LQuery.FieldByName('TEXTO').AsString;
      LQuery.Next;

      FPublicacoProria4.Data  := LQuery.FieldByName('DATA').AsString;
      FPublicacoProria4.Texto := LQuery.FieldByName('TEXTO').AsString;
      LQuery.Next;

    except
      on E: Exception do
        raise Exception.Create('ERRO AO CONSULTAR AS PUBLICAÇÕES DO USUARIO');
    end;
  finally
    //FreeAndNil(LQuery);
  end;
end;

end.
