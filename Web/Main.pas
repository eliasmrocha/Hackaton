unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniButton, uniLabel,
  uniGUIBaseClasses, uniEdit;

type
  TMainForm = class(TUniForm)
    UniEdit1: TUniEdit;
    UniLabel1: TUniLabel;
    UniButton1: TUniButton;
    procedure UniButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniButton1Click(Sender: TObject);
begin
  ShowMessage((UniMainModule.IdHTTP1.Get('http://192.168.1.28:9999/datasnap/rest/service/' + UniEdit1.Text)));
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
