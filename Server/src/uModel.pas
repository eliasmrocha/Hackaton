unit uModel;

interface
Uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
uUtilDB, FireDAC.Comp.Client, Data.DB, DBXJSON ;

type
  TModel = class
    private
      fFields   : TFields;

      function Adicionar : Boolean;
      function Atualizar : Boolean;
    public
      Cliente_ID             : Integer;
      Cliente_Nome           : String ;
      Cliente_DataNascimento : TDate  ;
      Cliente_Telefone       : String ;
      Cliente_Email          : String ;
      Cliente_DataCadastro   : TDate  ;

      class function RetornarTodosRegistros : tDataSet;
      class function RetornarRegistroById(pnId : Integer) : TDataSet;
      class procedure DeletarRegistroById(pnId : Integer);

      function Salvar : Boolean;

      procedure Assign(json : TJSONObject);
  end;

implementation

{ TCliente }

function TCliente.Adicionar: Boolean;
Var
  oQuery : TFDQuery;
begin
  oQuery := TFDQuery.Create(ConexaoDB.Connection);
  try
    try
      oQuery.Connection := ConexaoDB.Connection;
      oQuery.SQL.Clear;
      oQuery.SQL.Add('Insert into Cliente (       ');
      oQuery.SQL.Add('    Cliente_ID            , ');
      oQuery.SQL.Add('    Cliente_Nome          , ');
      oQuery.SQL.Add('    Cliente_DataNascimento, ');
      oQuery.SQL.Add('    Cliente_Telefone      , ');
      oQuery.SQL.Add('    Cliente_Email         , ');
      oQuery.SQL.Add('    Cliente_DataCadastro    ');
      oQuery.SQL.Add(')values(                    ');
      oQuery.SQL.Add('    :Cliente_ID            ,');
      oQuery.SQL.Add('    :Cliente_Nome          ,');
      oQuery.SQL.Add('    :Cliente_DataNascimento,');
      oQuery.SQL.Add('    :Cliente_Telefone      ,');
      oQuery.SQL.Add('    :Cliente_Email         ,');
      oQuery.SQL.Add('    :Cliente_DataCadastro   ');
      oQuery.SQL.Add(')                           ');

      oQuery.ParamByName('Cliente_ID'            ).AsInteger := ConexaoDB.NovoID('Cliente','Cliente_ID');
      oQuery.ParamByName('Cliente_Nome'          ).AsString  := Cliente_Nome;
      oQuery.ParamByName('Cliente_DataNascimento').AsDate    := Cliente_DataNascimento;
      oQuery.ParamByName('Cliente_Telefone'      ).AsString  := Cliente_Telefone;
      oQuery.ParamByName('Cliente_Email'         ).AsString  := Cliente_Email;
      oQuery.ParamByName('Cliente_DataCadastro'  ).AsDateTime:= Now();
      oQuery.ExecSQL;

      Result := true;
    except
      Result := false;
    end;
  finally
    FreeAndNil(oQuery);
  end;
end;

procedure TCliente.Assign(json: TJSONObject);
begin
  Cliente_ID             := json.GetValue('Cliente_ID'            ).Value.ToInteger;
  Cliente_Nome           := json.GetValue('Cliente_Nome'          ).Value;
  Cliente_DataNascimento := StrToDate(json.GetValue('Cliente_DataNascimento').Value);
  Cliente_Telefone       := json.GetValue('Cliente_Telefone'      ).Value;
  Cliente_Email          := json.GetValue('Cliente_Email'         ).Value;
end;

function TCliente.Atualizar: Boolean;
Var
  oQuery : TFDQuery;
begin
  oQuery := TFDQuery.Create(ConexaoDB.Connection);
  try
    try
      oQuery.Connection := ConexaoDB.Connection;
      oQuery.SQL.Clear;
      oQuery.SQL.Add('Update Cliente Set                                   ');
      oQuery.SQL.Add('    Cliente_Nome            =:Cliente_Nome          , ');
      oQuery.SQL.Add('    Cliente_DataNascimento  =:Cliente_DataNascimento, ');
      oQuery.SQL.Add('    Cliente_Telefone        =:Cliente_Telefone      , ');
      oQuery.SQL.Add('    Cliente_Email           =:Cliente_Email         , ');
      oQuery.SQL.Add('    Cliente_DataCadastro    =:Cliente_DataCadastro    ');
      oQuery.SQL.Add('Where Cliente_ID =:Cliente_ID');

      oQuery.ParamByName('Cliente_ID'            ).AsInteger := Cliente_ID;
      oQuery.ParamByName('Cliente_Nome'          ).AsString  := Cliente_Nome;
      oQuery.ParamByName('Cliente_DataNascimento').AsDate    := Cliente_DataNascimento;
      oQuery.ParamByName('Cliente_Telefone'      ).AsString  := Cliente_Telefone;
      oQuery.ParamByName('Cliente_Email'         ).AsString  := Cliente_Email;
      oQuery.ParamByName('Cliente_DataCadastro'  ).AsDateTime:= Now();
      oQuery.ExecSQL;

      Result := true;
    except
      Result := false;
    end;
  finally
    FreeAndNil(oQuery);
  end;
end;

class procedure TCliente.DeletarRegistroById(pnId: Integer);
Var
  oQuery : TFDQuery;
begin
  oQuery := TFDQuery.Create(ConexaoDB.Connection);

  oQuery.Connection := ConexaoDB.Connection;
  oQuery.SQL.Clear;
  oQuery.SQL.Add('Delete From Cliente           ');
  oQuery.SQL.Add('Where Cliente_ID = :Cliente_ID');

  oQuery.ParamByName('Cliente_ID').AsInteger :=  pnId;
  oQuery.ExecSQL;
end;

class function TCliente.RetornarRegistroById(pnId : Integer): TDataSet;
Var
  oQuery : TFDQuery;
begin
  oQuery := TFDQuery.Create(ConexaoDB.Connection);

  oQuery.Connection := ConexaoDB.Connection;
  oQuery.SQL.Clear;
  oQuery.SQL.Add('Select * From Cliente         ');
  oQuery.SQL.Add('Where Cliente_ID = :Cliente_ID');

  oQuery.ParamByName('Cliente_ID').AsInteger :=  pnId;
  oQuery.Open;

  Result := oQuery;
end;

class function TCliente.RetornarTodosRegistros: tDataSet;
Var
  oQuery : TFDQuery;
begin
  oQuery := TFDQuery.Create(ConexaoDB.Connection);

  oQuery.Connection := ConexaoDB.Connection;
  oQuery.SQL.Clear;
  oQuery.SQL.Text := 'Select * From Cliente';
  oQuery.Open;

  Result := oQuery;
end;

function TCliente.Salvar: Boolean;
begin
  if Cliente_ID > 0 then
    Atualizar
  else
    Adicionar;
end;

end.
