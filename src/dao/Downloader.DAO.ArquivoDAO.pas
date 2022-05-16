unit Downloader.DAO.ArquivoDAO;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  FireDAC.Phys.SQLiteWrapper,
  Downloader.Exceptions,
  Downloader.ResourceStr,
  Downloader.Conexao.Factory,
  Downloader.Constantes.ComandosSQL,
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Model.Arquivo,
  Downloader.DAO.Interfaces.ArquivoDAO;

type
  TArquivoDAO = class(TInterfacedObject, IArquivoDAO)
  private
    function RetornarCodigoDownloadGravado(): Integer;
    constructor CreatePrivate();
  public
    class function New(): IArquivoDAO;

    procedure Gravar(pArquivo: IArquivo);
    procedure Atualizar(pArquivo: IArquivo);
    procedure RetornarListaDownloads(pLista: TList<IArquivo>);
  end;

implementation

{ TArquivoDAO }

procedure TArquivoDAO.Atualizar(pArquivo: IArquivo);
var
  lQuery: TFDQuery;
begin
  try
    lQuery := TFDQuery.Create(nil);
    try
      lQuery.Connection := TConexaoFactory.GetInstancia().GetConexao().Conexao;
      lQuery.SQL.Add(CSQLite_AtualizarArquivo);
      lQuery.Params.ParamByName('codigo').AsInteger := pArquivo.IdDatabase;
      lQuery.Params.ParamByName('datafim').AsDateTime := pArquivo.DataHoraFim;

      if ((pArquivo.Finalizado) and (pArquivo.DataHoraFim = 0)) then
        lQuery.Params.ParamByName('datafim').Clear;

      lQuery.ExecSQL();

      if lQuery.RowsAffected = 0 then
        raise EErroBancoDadosGravacao.Create(rsDMLErrorAtualizacaoRowsAffectedZero);
    finally
      FreeAndNil(lQuery);
    end;
  except
    on E: ESQLiteNativeException do
    begin
      raise EErroBancoDadosTabelaInvalida.Create(rsTabelaInvalida);
    end;

    on E: Exception do
      raise;
  end;
end;

constructor TArquivoDAO.CreatePrivate();
begin
  inherited Create;
end;

procedure TArquivoDAO.Gravar(pArquivo: IArquivo);
var
  lQuery: TFDQuery;
begin
  try
    lQuery := TFDQuery.Create(nil);
    try
      lQuery.Connection := TConexaoFactory.GetInstancia().GetConexao().Conexao;
      lQuery.SQL.Add(CSQLite_GravarArquivo);
      lQuery.Params.ParamByName('url').AsString := pArquivo.Url;
      lQuery.Params.ParamByName('datainicio').AsDateTime := pArquivo.DataHoraInicio;
      lQuery.ExecSQL();

      if lQuery.RowsAffected = 0 then
        raise EErroBancoDadosGravacao.Create(rsDMLErrorInsercaoRowsAffectedZero);

      pArquivo.IdDatabase := RetornarCodigoDownloadGravado();
    finally
      FreeAndNil(lQuery);
    end;
  except
    on E: ESQLiteNativeException do
    begin
      raise EErroBancoDadosTabelaInvalida.Create(rsTabelaInvalida);
    end;

    on E: Exception do
      raise;
  end;
end;

class function TArquivoDAO.New(): IArquivoDAO;
begin
  Result := Self.CreatePrivate();
end;

function TArquivoDAO.RetornarCodigoDownloadGravado(): Integer;
var
  lQuery: TFDQuery;
begin
  try
    lQuery := TFDQuery.Create(nil);
    try
      lQuery.Connection := TConexaoFactory.GetInstancia().GetConexao().Conexao;
      lQuery.SQL.Add(CSQLite_RetornarCodigoGravado);
      lQuery.Open();

      Result := lQuery.Fields.FieldByName('codigo').AsInteger;
    finally
      FreeAndNil(lQuery);
    end;
  except
    on E: ESQLiteNativeException do
    begin
      raise EErroBancoDadosTabelaInvalida.Create(rsTabelaInvalida);
    end;

    on E: Exception do
      raise;
  end;
end;

procedure TArquivoDAO.RetornarListaDownloads(pLista: TList<IArquivo>);
var
  lArquivo: IArquivo;
  lQuery: TFDQuery;
  lDataFim: TDateTime;
begin
  try
    lQuery := TFDQuery.Create(nil);
    try
      lQuery.Connection := TConexaoFactory.GetInstancia().GetConexao().Conexao;
      lQuery.SQL.Add(CSQLite_RetornarListaDownloads);
      lQuery.Open();

      if lQuery.IsEmpty() then
        raise EErroBancoDadosSemRegistros.Create(rsDMLErrorInsercaoRowsAffectedZero);

      lQuery.First();
      while not lQuery.Eof do
      begin
        lDataFim := 0;

        if not lQuery.Fields.FieldByName('datafim').IsNull then
          lDataFim := lQuery.Fields.FieldByName('datafim').AsDateTime;

        lArquivo                := TArquivo.New();
        lArquivo.Id             := lQuery.Fields.FieldByName('codigo').AsInteger;
        lArquivo.IdDatabase     := lQuery.Fields.FieldByName('codigo').AsInteger;
        lArquivo.Url            := lQuery.Fields.FieldByName('url').AsString;
        lArquivo.DataHoraInicio := lQuery.Fields.FieldByName('datainicio').AsDateTime;
        lArquivo.DataHoraFim    := lDataFim;
        lArquivo.Finalizado     := not lQuery.Fields.FieldByName('datafim').IsNull;
        pLista.Add(lArquivo);

        lQuery.Next();
      end;
    finally
      FreeAndNil(lQuery);
    end;
  except
    on E: ESQLiteNativeException do
    begin
      raise EErroBancoDadosTabelaInvalida.Create(rsTabelaInvalida);
    end;

    on E: Exception do
      raise;
  end;
end;

end.
