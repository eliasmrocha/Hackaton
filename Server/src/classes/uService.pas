unit uService;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  Data.DB, DBXJSON, System.JSON, uVenda;

type
{$METHODINFO ON}
  Service = class(TComponent)
  private
    function ClienteSalvar(jsonCliente : TJSONObject): Boolean;
    function ProdutoSalvar(jsonProduto : TJSONObject): Boolean;
  public
    function Ping: string;
    function Cliente(pnIdCliente : Integer) : TJSONArray;
    function acceptCliente(jsonCliente : TJSONObject) : String;
    function updateCliente(jsonCliente : TJSONObject) : String;
    function cancelCliente(pnIdCliente : Integer) : String;

    function Produto(pnIdProduto : Integer) : TJSONArray;
    function acceptProduto(jsonProduto : TJSONObject) : String;
    function updateProduto(jsonProduto : TJSONObject) : String;
    function cancelProduto(pnIdProduto : Integer) : String;

    function Venda(pnIdVenda : Integer) : TJSONArray;
    function acceptVenda(jsonVenda : TJSONObject) : String;

    //Novos serviços
    function updateVenda(AJSONVenda : TJSONObject) : String;

  end;
{$METHODINFO OFF}

  function DataSetToJSON(oDataSet : TDataset) : TJSONArray;

implementation

uses
  udmConexao;


{ Service }

{Cliente}

function Service.Ping: string;
begin
  Result := 'OK';
end;

function Service.Produto(pnIdProduto: Integer): TJSONArray;
begin
//  if pnIdProduto > 0 then
//    result := DataSetToJSON(TProduto.RetornarRegistroById(pnIdProduto))
//  else
//    result := DataSetToJSON(TProduto.RetornarTodosRegistros);
end;

function Service.ProdutoSalvar(jsonProduto: TJSONObject): Boolean;
//Var Produto : TProduto;
begin
//  Produto := TProduto.Create();
//  try
//    Produto.Assign(jsonProduto);
//    Produto.Salvar;
//  finally
//    Produto.Free;
//  end;
end;

function Service.acceptCliente(jsonCliente : TJSONObject): String;
Begin
  ClienteSalvar(jsonCliente);
end;

function Service.acceptProduto(jsonProduto: TJSONObject): String;
begin
  ProdutoSalvar(jsonProduto);
end;

function Service.acceptVenda(jsonVenda: TJSONObject): String;
//Var Venda : TVenda;
begin
//  Venda := TVenda.Create();
//  try
//    Venda.Assign(jsonVenda);
//    Venda.Adicionar;
//  finally
//    Venda.Free;
//  end;
end;

function Service.cancelCliente(pnIdCliente : Integer): String;
begin
//  TCliente.DeletarRegistroById(pnIdCliente);
end;

function Service.cancelProduto(pnIdProduto: Integer): String;
begin
//  TProduto.DeletarRegistroById(pnIdProduto)
end;

function Service.Cliente(pnIdCliente : Integer): TJSONArray;
begin
//  if pnIdCliente > 0 then
//    result := DataSetToJSON(TCliente.RetornarRegistroById(pnIdCliente))
//  else
//    result := DataSetToJSON(TCliente.RetornarTodosRegistros);
end;


function Service.ClienteSalvar(jsonCliente : TJSONObject): Boolean;
//Var Cliente : TCliente;
begin
//  Cliente := TCliente.Create();
//  try
//    Cliente.Assign(jsonCliente);
//    Cliente.Salvar;
//  finally
//    Cliente.Free;
//  end;
end;

function Service.updateCliente(jsonCliente : TJSONObject): String;
begin
  ClienteSalvar(jsonCliente);
end;

function Service.updateProduto(jsonProduto: TJSONObject): String;
begin
  ProdutoSalvar(jsonProduto);
end;

function Service.updateVenda(AJSONVenda: TJSONObject): String;
var
  LVenda : TVenda;
begin
  LVenda := TVenda.Create(dmConexao.fdConexao);
  try
    LVenda.Assign(AJSONVenda);
    LVenda.CadastraVenda;
  finally
    LVenda.Free;
  end;
end;

function Service.Venda(pnIdVenda: Integer): TJSONArray;
begin
//  if pnIdVenda > 0 then
//    result := TVenda.RetornarRegistroById(pnIdVenda)
//  else
//    result := TVenda.RetornarTodosRegistros;
end;

function DataSetToJSON(oDataSet : TDataset) : TJSONArray;
Var
  JObject  : TJSONObject;
  i        : Integer;
begin
  Result   := TJSONArray.Create;
  oDataSet.First;
  while Not(oDataSet.Eof) do
  begin
    JObject := TJSONObject.Create;
    for i := 0 to oDataSet.FieldCount-1 do
      JObject.AddPair(oDataSet.Fields[i].FieldName, TJSONString.Create(oDataSet.Fields[i].AsString));

    Result.AddElement(JObject);
    oDataSet.Next;
  end;
end;

end.

