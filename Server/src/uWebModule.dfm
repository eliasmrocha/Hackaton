object WebMod: TWebMod
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
    end>
  Height = 190
  Width = 288
  object DSServer: TDSServer
    Left = 96
    Top = 11
  end
  object DSHTTPWebDispatcher: TDSHTTPWebDispatcher
    Server = DSServer
    Filters = <>
    WebDispatch.PathInfo = 'datasnap*'
    Left = 96
    Top = 75
  end
  object DSServerClass: TDSServerClass
    OnGetClass = DSServerClassGetClass
    Server = DSServer
    Left = 200
    Top = 11
  end
end
