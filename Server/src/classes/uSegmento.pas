unit uSegmento;

interface

uses
  FireDAC.Comp.Client;

type
  TSegmento = class
  private
    FId: Integer;
    FNome: string;
    FConexao: TFDConnection;
    { Private Declarations }
  public
    constructor Create(AConexao: TFDConnection);

    //Métodos públicos
    procedure LocalizaSegmento(AId: Integer);

    //Propriedades
    property Id  : Integer read FId   write FId;
    property Nome: string  read FNome write FNome;
    { Public Declarations }
  end;

implementation

uses
  System.SysUtils;

{ TSegmento }

constructor TSegmento.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

procedure TSegmento.LocalizaSegmento(AId: Integer);
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(FConexao);
  try
    try
      LQuery.Connection := FConexao;

      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT     ');
      LQuery.SQL.Add('  nome     ');
      LQuery.SQL.Add('FROM       ');
      LQuery.SQL.Add('  segmento ');
      LQuery.SQL.Add('WHERE      ');
      LQuery.SQL.Add('  id =:id  ');

      LQuery.ParamByName('id').AsInteger := AId;
      LQuery.Open();

      if LQuery.RecordCount <> 0 then
      begin
        FId := AId;
        FNome := LQuery.FieldByName('nome').AsString;
      end;
    except
      raise Exception.Create('ERRO AO LOCALIZAR O SEGMENTO');
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

end.
