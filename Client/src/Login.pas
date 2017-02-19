unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON, DBXJSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TFrm_Login = class(TForm)
    Label1: TLabel;
    edLogin: TEdit;
    edSenha: TEdit;
    Label2: TLabel;
    BtnLogin: TButton;
    IdHTTP1: TIdHTTP;
    procedure BtnLoginClick(Sender: TObject);
    function ConsumeJsonBytes(AJsonString: String): TJSONObject;
  private
    { Private declarations }
  public
    FLoginValido : Boolean;
    FId          : string;
    FNome        : string;
    FEmail       : string;
  end;

var
  Frm_Login: TFrm_Login;

implementation

{$R *.dfm}

uses HKCripto;

procedure TFrm_Login.BtnLoginClick(Sender: TObject);
var
  LJson     : TJSONObject;
  Lresponse : string;
begin
  LJson   := TJSONObject.Create;
  try
    try
      Lresponse := IdHTTP1.get('http://192.168.1.28:9991/datasnap/rest/service/RetornaDadosUsuario/' + edLogin.Text + '/' + HKCripto.EncriptPassword(edSenha.Text));
      LJson     := ConsumeJsonBytes(Lresponse);

      FId       := LJson.GetValue('ID').Value;
      FNome     := LJson.GetValue('NOME').Value;
      FEmail    := LJson.GetValue('EMAIL').Value;
    Except
      Application.Terminate;
    end;
  finally
    FreeAndNil(LJson);
  end;
end;

function TFrm_Login.ConsumeJsonBytes(AJsonString: String): TJSONObject;
begin
  Result := nil;
  Result := TJsonObject.Create;
  Result.Parse(BytesOf(AJsonString), 0);
end;

end.
