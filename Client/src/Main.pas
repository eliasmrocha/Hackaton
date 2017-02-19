unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.Themes, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

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
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure BuscarPublicacoesProprias;
    procedure BuscarPublicacoesAmigos;
    procedure BuscarIndicaoesAmigos;
    procedure BuscarUltimasCompras;

  private
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

uses Login;

procedure TForm1.BuscarIndicaoesAmigos;
begin
  FSugestaoAmizade1 := TSugestoesAmigos.Create;
  FSugestaoAmizade2 := TSugestoesAmigos.Create;

//  SugestoesAmigos
end;

procedure TForm1.BuscarPublicacoesAmigos;
begin
  FPublicacaoAmigos1 := TPublicacaoAmigos.Create;
  FPublicacaoAmigos2 := TPublicacaoAmigos.Create;
  FPublicacaoAmigos3 := TPublicacaoAmigos.Create;
  FPublicacaoAmigos4 := TPublicacaoAmigos.Create;

//  PublicacoesAmigos
end;

procedure TForm1.BuscarPublicacoesProprias;
var
  LJson     : TJSONObject;
  LNoJson   : TJSONObject;
  LString   : String;
  Lresponse : string;
begin
  FPublicacoProria1 := TPublicacaoPropria.Create;
  FPublicacoProria2 := TPublicacaoPropria.Create;
  FPublicacoProria3 := TPublicacaoPropria.Create;
  FPublicacoProria4 := TPublicacaoPropria.Create;

  LJson := TJSONObject.Create;
  try
    Lresponse := IdHTTP1.Get('http://192.168.1.28:9991/datasnap/rest/service/PublicacoesProprias/' + Frm_Login.FId);
    LJson     := ConsumeJsonBytes(Lresponse);

    FPublicacoProria1.Data  := LJson.GetValue('DATA').Value;
    FPublicacoProria1.Texto := LJson.GetValue('TEXTO').Value;
  finally
    FreeAndNil(LJson);
  end;
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
  BuscarPublicacoesProprias;
  BuscarPublicacoesAmigos;
  BuscarIndicaoesAmigos;
  BuscarUltimasCompras;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
end;

end.
