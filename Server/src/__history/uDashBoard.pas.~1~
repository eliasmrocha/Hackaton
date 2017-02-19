unit uDashBoard;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Datasnap.DBClient, System.IniFiles, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient;

type
  TDashBoard = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    ApplicationEvents: TApplicationEvents;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;

    procedure FormCreate(Sender: TObject);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DashBoard: TDashBoard;

implementation

{$R *.dfm}

uses
  Winapi.ShellApi, Datasnap.DSSession, udmConexao;

procedure TDashBoard.ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
end;

procedure TDashBoard.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TDashBoard.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TDashBoard.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TDashBoard.StartServer;
var
  LIniFile: TIniFile;
begin
  LIniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\CS Server.ini');
  try
    if not FServer.Active then
    begin
      FServer.Bindings.Clear;
      FServer.DefaultPort := LIniFile.ReadInteger('CONFIG', 'port', 9090);
      FServer.Active := True;
    end;

    dmConexao.ConectaDB;
  finally
    FreeAndNil(LIniFile);
  end;
end;

end.
