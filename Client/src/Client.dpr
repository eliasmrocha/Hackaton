program Client;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  Login in 'Login.pas' {Frm_Login},
  HKCripto in '..\..\Core\HKCripto.pas',
  HKConst_Alfabeto in '..\..\Core\HKConst_Alfabeto.pas',
  uUtils in '..\..\Server\src\utils\uUtils.pas',
  udmConexao in '..\..\Server\src\db\udmConexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TdmConexao, dmConexao);

  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
