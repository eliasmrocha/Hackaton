unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, rest.json, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone47in.fmx IOS}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm1.Button1Click(Sender: TObject);
var
  LJson : TJSONObject;
  LStream: TStringStream;
  LString: String;
  Lresponse : string;
begin

  LString :=
    '{'
    +'"id_cliente":"' + Edit1.Text + '",'
    + '"cnpj":' + Edit3.Text
    + '}';

  LStream := TStringStream.Create(LString);

  LJson := TJSONObject.Create;
  try
    Lresponse := IdHTTP1.Post(Edit2.Text, LStream);
  finally
    FreeAndNil(LJson);
  end;
end;

end.
