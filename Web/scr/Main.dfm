object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 201
  ClientWidth = 447
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniEdit1: TUniEdit
    Left = 168
    Top = 112
    Width = 121
    Hint = ''
    Text = ''
    TabOrder = 0
  end
  object UniLabel1: TUniLabel
    Left = 104
    Top = 112
    Width = 31
    Height = 13
    Hint = ''
    Caption = 'Nome:'
    TabOrder = 1
  end
  object UniButton1: TUniButton
    Left = 352
    Top = 168
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = UniButton1Click
  end
end
