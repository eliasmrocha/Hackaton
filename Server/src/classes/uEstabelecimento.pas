unit uEstabelecimento;

interface

uses
  uCliente;

type
  TEstabelecimento = class(TCliente)
  private
    { Private Declarations }
  public
    //M�todos p�blicos
    procedure LocalizaEstabelecimentoPorCNPJ(ACNPJ: string);

    //Propriedades
//    property CNPJ           : string    read FCNPJ           write FCNPJ;
//    property Segmento      : string     read FSexo            write FSexo;
//    property DataNascimento: TDateTime  read FDataNascimento  write FDataNascimento;
//    property Senha         : string     read FSenha           write FSenha;
    { Public Declarations }
  end;

implementation

{ TEstabelecimento }

procedure TEstabelecimento.LocalizaEstabelecimentoPorCNPJ(ACNPJ: string);
begin

end;

end.
