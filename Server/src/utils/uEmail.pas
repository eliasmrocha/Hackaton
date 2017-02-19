unit uEmail;

interface

uses
  IdSMTP, IdSSLOpenSSL, IdMessage;

type
  TEmail = class
  private
    FSMTP: TIdSMTP;
    FSSLSocket: TIdSSLIOHandlerSocketOpenSSL;
    FIdMessage: TIdMessage;

    FEmailRemetente: string;
    FEmailDestinatrio: string;
    FSenha: string;
    FHost: string;
    FPorta: Integer;
    FAssunto: string;
    { Private Declarations }
  public
    constructor Create(AEmailRemetente, AEmailDestinatario, ASenha, AHost, AAssunto: string; APorta: Integer);
    procedure EnviarEmail();
    { Public Declarations }
  end;

implementation

uses
  System.Classes, HKCripto, Vcl.ComCtrls, IdExplicitTLSClientServerBase,
  IdText, System.SysUtils;

{ TEmail }

constructor TEmail.Create(AEmailRemetente, AEmailDestinatario, ASenha, AHost, AAssunto: string;
  APorta: Integer);
begin
  FEmailRemetente   := AEmailRemetente;
  FEmailDestinatrio := AEmailDestinatario;
  FSenha            := ASenha;
  FHost             := AHost;
  FAssunto          := AAssunto;
  FPorta            := APorta;
end;

procedure TEmail.EnviarEmail;
var
  I : Integer;
  LIdSMTP         : TIdSMTP;
  LIdSSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
  LIdMessage      : TIdMessage;
  LTexto          : TStringList;
  LS              : string;
  LIdText         : TIdText;
begin
  LIdSMTP         := TIdSMTP.Create(nil);
  LIdSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create();
  LIdMessage      := TIdMessage.Create();

  LIdSMTP.Disconnect;

  LIdSMTP.Host     := FHost;
  LIdSMTP.Port     := FPorta;
  LIdSMTP.Username := FEmailRemetente;
  LIdSMTP.Password := DecriptPassword(FSenha);

  LIdSMTP.AuthType  := satDefault;

  LIdSSLIOHandler.SSLOptions.Method := sslvTLSv1;
  LIdSSLIOHandler.SSLOptions.Mode   := sslmClient;
  LIdSMTP.IOHandler                 := LIdSSLIOHandler;
  LIdSMTP.UseTLS                    := utUseImplicitTLS;

  LIdMessage.Clear;
  LIdMessage.Body.Clear;
  LIdMessage.Recipients.Clear;
  LIdMessage.From.Address              := FEmailRemetente;
  LIdMessage.From.Name                 := FEmailRemetente;
  LIdMessage.ReceiptRecipient.Address  := FEmailRemetente;
  LIdMessage.Subject                   := FAssunto;
  LIdMessage.ContentType               := 'multipart/mixed';

  LS := '';
  LS := FEmailDestinatrio;

  LS := LS + ';' + FEmailRemetente;

  LIdMessage.Recipients.EMailAddresses := LS;
  LIdText := TIdText.Create(LIdMessage.MessageParts);
  LIdText.ContentType     := 'text/html';
  LIdText.ContentTransfer := '7bit';
  LIdText.Body.Append('HACKATON - CONDUCTOR <br>');
  LIdText.Body.Append('Para se cadastrar, acesse o link abaixo <br>');
  LIdText.Body.Append('http://localhost:8077?email=' + FEmailDestinatrio + ' <br>');

  LIdSMTP.Disconnect;

  try
    LIdSMTP.Connect;

    LIdSMTP.Authenticate;
    LIdSMTP.Send(LIdMessage);
    LIdSMTP.Disconnect;
  except
    LIdSMTP.Disconnect;
  end;

  FreeAndNil(LIdMessage);
  FreeAndNil(LIdSSLIOHandler);
  FreeAndNil(LIdSMTP);
end;

end.
