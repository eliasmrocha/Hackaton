object Frm_Login: TFrm_Login
  Left = 0
  Top = 0
  Caption = 'Frm_Login'
  ClientHeight = 157
  ClientWidth = 238
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 42
    Top = 37
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'Login:'
  end
  object Label2: TLabel
    Left = 37
    Top = 64
    Width = 34
    Height = 13
    BiDiMode = bdLeftToRight
    Caption = 'Senha:'
    ParentBiDiMode = False
  end
  object edLogin: TEdit
    Left = 77
    Top = 34
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edSenha: TEdit
    Left = 77
    Top = 61
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object BtnLogin: TButton
    Left = 81
    Top = 98
    Width = 75
    Height = 25
    Caption = 'Login'
    ModalResult = 1
    TabOrder = 2
    OnClick = BtnLoginClick
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 112
    Top = 88
  end
end
