unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TdmConexao = class(TDataModule)
    fdConexao: TFDConnection;
  private
    procedure ConfigurarDB;
    { Private declarations }
  public
    procedure ConectaDB;
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

uses
  System.IniFiles, HKCripto, Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmConexao }

procedure TdmConexao.ConectaDB;
begin
  ConfigurarDB;
  try
    fdConexao.Connected := True;
  except
    raise Exception.Create('Problema ao conectar ao servidor de banco de dados.');
  end;
end;

procedure TdmConexao.ConfigurarDB;
var
  LIniFile: TIniFile;
begin
  // Passa os parametros de Conex�o e Conecta ao Banco de Dados
  LIniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\CS Server.ini');
  try
    fdConexao.LoginPrompt := False;
    fdConexao.Params.Clear;
    fdConexao.Params.Values['Database']  := LIniFile.ReadString('DATABASE', 'Database', 'XE');
    fdConexao.Params.Values['User_Name'] := LIniFile.ReadString('DATABASE', 'user'    , '');
    fdConexao.Params.Values['Password']  := DecriptPassword(LIniFile.ReadString('DATABASE', 'pwd', ''));
    fdConexao.Params.Values['DriverID']  := 'Ora';
  finally
    FreeAndNil(LIniFile);
  end;
end;

end.
