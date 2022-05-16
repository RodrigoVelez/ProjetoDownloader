unit Downloader.Controller.Arquivo;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Threading,
  System.Generics.Collections,
  Downloader.Model.Arquivo,
  Downloader.DAO.ArquivoDAO,
  Download.Model.Interfaces.RequisicaoHTTP,
  Downloader.DAO.Interfaces.ArquivoDAO,
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Controller.Interfaces.Arquivo,
  Downloader.Model.RequisicaoHTTP.Factory,
  Downloader.Observer.Interfaces.Subject,
  Downloader.Observer.Interfaces.Observer;
type
  TControllerArquivo = class(TInterfacedObject, IControllerArquivo, IObserverDownload, ISubject)
  private
    FListaArquivosDownload: TList<IArquivo>;
    FListaTasks: array of ITask;
    FObservers: TList<IObserverDownload>;

    procedure Notificar();
    procedure Atualizar(pArquivo: IArquivo);

    procedure PersistirDownloadDatabase(pArquivo: IArquivo);
    procedure AtualizarDownloadDatabase(pArquivo: IArquivo);

    constructor CreatePrivate();
  public
    class function New(): IControllerArquivo;
    destructor Destroy(); override;

    procedure AdicionarObserver(pObserver: IObserverDownload);

    procedure RetornarHistoricoListaDownloadJaExecutados(pLista: TList<IArquivo>);
    function RetornarListaDownloasEmExecucao(): TList<IArquivo>;
    procedure AdicionarDownloadListaDeExecucao(const pUrl: string);

    function ExisteDownloadEmExecucao(): Boolean;
    procedure PararDownloadEmExecucao(const pId: Integer);
    procedure PararTodosDownloadsEmExecucao();
  end;

implementation

{ TControllerArquivo }

procedure TControllerArquivo.AdicionarDownloadListaDeExecucao(const pUrl: string);
var
  lTask: ITask;
  lArquivo: IArquivo;
begin
  lArquivo := TArquivo.New();
  lArquivo.Id := Length(FListaTasks) + 1;
  lArquivo.Url := pUrl;

  SetLength(FListaTasks, lArquivo.Id);

  PersistirDownloadDatabase(lArquivo);

  lTask := TTask.Run(
    procedure
    var
      lRequisicaoHTTP: IRequisicaoHTTP;
    begin
      lRequisicaoHTTP := TRequisicaoHTTPFactory.GetInstancia().GetRequisicaoHTTP();
      lRequisicaoHTTP.AdicionarObserver(Self);
      lRequisicaoHTTP.Enviar(lArquivo);
    end
  );
  lTask.Start();

  FListaArquivosDownload.Add(lArquivo);
  FListaTasks[lArquivo.Id - 1] := lTask;
end;

procedure TControllerArquivo.AdicionarObserver(pObserver: IObserverDownload);
begin
  FObservers.Add(pObserver);
end;

procedure TControllerArquivo.Atualizar(pArquivo: IArquivo);
var
  I: Integer;
  lObserver: IObserverDownload;
begin
  for I := 0 to FListaArquivosDownload.Count - 1 do
  begin
    if FListaArquivosDownload[I].Id = pArquivo.Id then
    begin
      FListaArquivosDownload[I].IdDatabase    := pArquivo.IdDatabase;
      FListaArquivosDownload[I].BytesBaixados := pArquivo.BytesBaixados;
      FListaArquivosDownload[I].BytesTotal    := pArquivo.BytesTotal;
      FListaArquivosDownload[I].Percentual    := pArquivo.Percentual;
      FListaArquivosDownload[I].DataHoraFim   := pArquivo.DataHoraFim;
      FListaArquivosDownload[I].Finalizado    := pArquivo.Finalizado;

      if (pArquivo.Finalizado) then
        AtualizarDownloadDatabase(pArquivo);

      for lObserver in FObservers do
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            lObserver.Atualizar(FListaArquivosDownload[I]);
          end
        );
      end;

      Break;
    end;
  end;
end;

procedure TControllerArquivo.AtualizarDownloadDatabase(pArquivo: IArquivo);
var
  LArquivoDAO: IArquivoDAO;
begin
  LArquivoDAO := TArquivoDAO.New();
  LArquivoDAO.Atualizar(pArquivo);
end;

constructor TControllerArquivo.CreatePrivate();
begin
  inherited Create;
  FListaArquivosDownload := TList<IArquivo>.Create();
  FObservers             := TList<IObserverDownload>.Create;

  SetLength(FListaTasks, 0);
end;

destructor TControllerArquivo.Destroy();
begin
  FreeAndNil(FListaArquivosDownload);
  FreeAndNil(FObservers);

  inherited;
end;

function TControllerArquivo.ExisteDownloadEmExecucao(): Boolean;
var
  lItem: ITask;
begin
  Result := False;

  for lItem in FListaTasks do
  begin
    if lItem.Status = TTaskStatus.Running then
    begin
      Result := True;
      Break;
    end;
  end;
end;

class function TControllerArquivo.New(): IControllerArquivo;
begin
  Result := TControllerArquivo.CreatePrivate();
end;

procedure TControllerArquivo.Notificar();
begin
  //Implementado no métodoAtualizar pois aqui não temos os dados do download corrente, apenas lá.
end;

procedure TControllerArquivo.PararDownloadEmExecucao(const pId: Integer);
var
  I: Integer;
begin
  for I := 0 to FListaArquivosDownload.Count - 1 do
  begin
    if FListaArquivosDownload[I].Id = pId then
    begin
      FListaTasks[I].Cancel();
    end;
  end;
end;

procedure TControllerArquivo.PararTodosDownloadsEmExecucao();
var
  I: Integer;
begin
  for I := 0 to FListaArquivosDownload.Count - 1 do
    FListaTasks[I].Cancel();

  TTask.WaitForAll(FListaTasks);
end;

procedure TControllerArquivo.PersistirDownloadDatabase(pArquivo: IArquivo);
var
  LArquivoDAO: IArquivoDAO;
begin
  LArquivoDAO := TArquivoDAO.New();
  LArquivoDAO.Gravar(pArquivo);
end;

function TControllerArquivo.RetornarListaDownloasEmExecucao: TList<IArquivo>;
begin
  Result := FListaArquivosDownload;
end;

procedure TControllerArquivo.RetornarHistoricoListaDownloadJaExecutados(pLista: TList<IArquivo>);
var
  LArquivoDAO: IArquivoDAO;
begin
  LArquivoDAO := TArquivoDAO.New();
  LArquivoDAO.RetornarListaDownloads(pLista);
end;

end.
