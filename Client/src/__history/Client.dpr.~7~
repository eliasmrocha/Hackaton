program Client;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  Login in 'Login.pas' {Frm_Login},
  HKCripto in '..\..\Core\HKCripto.pas',
  HKConst_Alfabeto in '..\..\Core\HKConst_Alfabeto.pas',
  uUtils in '..\..\Server\src\utils\uUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TFrm_Login, Frm_Login);
  Frm_Login.ShowModal;

  if Frm_Login.ModalResult = 1 then
  begin
    Frm_Login.close;
    Application.CreateForm(TForm1, Form1);
    Application.Run;
  end;
end.
