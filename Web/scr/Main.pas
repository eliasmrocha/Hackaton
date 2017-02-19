unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniButton, uniLabel,
  uniGUIBaseClasses, uniEdit, Vcl.Imaging.jpeg, uniImage, uniGroupBox, uniPanel,
  uniDateTimePicker, uniMultiItem, uniComboBox, System.JSON;

type
  TMainForm = class(TUniForm)
    UniImage1: TUniImage;
    UniPnFormulario: TUniPanel;
    UniGrFormulario: TUniGroupBox;
    UniButton1: TUniButton;
    pnTopo: TUniPanel;
    UniLabel1: TUniLabel;
    edEmail: TUniEdit;
    edNome: TUniEdit;
    UniLabel2: TUniLabel;
    pnEstabelecimento: TUniPanel;
    UniLabel4: TUniLabel;
    cbSegmentos: TUniComboBox;
    UniLabel3: TUniLabel;
    edCNPJ: TUniEdit;
    pnCliente: TUniPanel;
    UniLabel6: TUniLabel;
    cbSexo: TUniComboBox;
    UniLabel7: TUniLabel;
    dpNascimento: TUniDateTimePicker;
    UniLabel8: TUniLabel;
    edCPF: TUniEdit;
    pnEndereco: TUniPanel;
    UniLabel5: TUniLabel;
    edCep: TUniEdit;
    UniLabel9: TUniLabel;
    edRua: TUniEdit;
    UniLabel10: TUniLabel;
    edBairro: TUniEdit;
    edCidade: TUniEdit;
    UniLabel11: TUniLabel;
    UniLabel12: TUniLabel;
    edEstado: TUniEdit;
    UniLabel13: TUniLabel;
    cbTipoUsuario: TUniComboBox;
    UniLabel14: TUniLabel;
    edNumero: TUniEdit;
    procedure UniButton1Click(Sender: TObject);
    procedure UniPnFormularioAlignPosition(Sender: TWinControl;
      Control: TControl; var NewLeft, NewTop, NewWidth, NewHeight: Integer;
      var AlignRect: TRect; AlignInfo: TAlignInfo);
    procedure edCepExit(Sender: TObject);
    procedure cbTipoUsuarioChange(Sender: TObject);
    procedure UniFormActivate(Sender: TObject);
  private
    function ConsumeJsonBytes(AJsonString: String): TJSONObject;
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.edCepExit(Sender: TObject);
var
  LJson : TJSONObject;
  LString: String;
  Lresponse : string;
begin
  LJson := TJSONObject.Create;
  try
    LJson         := ConsumeJsonBytes(UniMainModule.IdHTTP1.Get('http://viacep.com.br/ws/' + edCep.Text + '/json/'));
    edRua.Text    := LJson.GetValue('logradouro').Value;
    edBairro.Text := LJson.GetValue('bairro'    ).Value;
    edCidade.Text := LJson.GetValue('localidade').Value;
    edEstado.Text := LJson.GetValue('uf'        ).Value;
  finally
    FreeAndNil(LJson);
  end;
end;

procedure TMainForm.UniButton1Click(Sender: TObject);
var
  LJson : TJSONObject;
  LStream: TStringStream;
  LString: String;
  Lresponse : string;
begin

  LString :=
    '{'
    +'"Cliente_Nome":"'           + edNome.Text                      + '",'
    +'"Cliente_DataNascimento":"' + DateToStr(dpNascimento.DateTime) + '",'
    +'"Cliente_cpf":"'            + edCPF.Text                       + '",'
    +'"Cliente_Email":"'          + edEmail.text                     + '",'
    +'"Cliente_cep":"'            + edCep.text                       + '",'
    +'"Cliente_rua":"'            + edRua.text                       + '",'
    +'"Cliente_bairro":"'         + edBairro.text                    + '",'
    +'"Cliente_cidade":"'         + edCidade.text                    + '",'
    +'"Cliente_uf":"'             + edEstado.text                    + '",'
    +'"Cliente_numero":"'         + edNumero.text                    + '"'
    +'}';

  LStream := TStringStream.Create(LString);

  LJson := TJSONObject.Create;
  try
    LJson.ParseJSONValue(UniMainModule.IdHTTP1.Post('http://192.168.1.28:9991/datasnap/rest/service/atualizacliente', LStream));
  finally
    FreeAndNil(LJson);
  end;
end;

procedure TMainForm.UniFormActivate(Sender: TObject);
var
  LEmail : String;
begin
  LEmail          := UniApplication.Parameters.Values['email'];
  edEmail.Enabled := LEmail = '';
  edEmail.Text    := LEmail;
end;

procedure TMainForm.cbTipoUsuarioChange(Sender: TObject);
begin
  if cbTipoUsuario.ItemIndex = 0 then
  begin
    pnCliente.Visible := True;
    pnEstabelecimento.Visible := False;
  end
  else
  begin
    pnEstabelecimento.Visible := True;
    pnCliente.Visible := False;
  end;
end;

procedure TMainForm.UniPnFormularioAlignPosition(Sender: TWinControl;
  Control: TControl; var NewLeft, NewTop, NewWidth, NewHeight: Integer;
  var AlignRect: TRect; AlignInfo: TAlignInfo);
begin
  if (Control = UniGrFormulario) or (Control.ClassType = TUniPanel) then
    NewLeft := AlignRect.Left + ((AlignRect.Width - Control.Width) div 2);
end;


function TMainForm.ConsumeJsonBytes(AJsonString: String): TJSONObject;
begin
  Result := nil;
  Result := TJsonObject.Create;
  Result.Parse(BytesOf(AJsonString), 0);
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
