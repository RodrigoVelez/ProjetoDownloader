unit Download.Model.RequisicaoHTTP;

interface

uses
  System.Classes,
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdURI,
  IdAntiFreezeBase,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdGlobal,
  IdAntiFreeze,
  Downloader.Utils,
  Downloader.Constantes,
  Download.Model.Interfaces.RequisicaoHTTP,
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Model.Arquivo,
  Downloader.Observer.Interfaces.Subject,
  Downloader.Observer.Interfaces.Observer,
  Downloader.Controller.Interfaces.Arquivo;

type
  TRequisicaoHTTP = class(TInterfacedObject, IRequisicaoHTTP, ISubject)
  private
    FPararThread: Boolean;
    FIdHttp: TIdHTTP;
    FIdSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    FDadosDownload: IArquivo;
    FTempo: TDateTime;
    FObservers: TList<IObserverDownload>;

    procedure Notificar();

    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);


    procedure ConfigurarRequisicaoHTTP();
    constructor CreatePrivate();
  public
    class function New(): IRequisicaoHTTP;
    destructor Destroy(); override;

    procedure AdicionarObserver(pObserver: IObserverDownload);
    procedure Enviar(pArquivo: IArquivo);
  end;

implementation

{ TRequisicaoHTTP }

procedure TRequisicaoHTTP.AdicionarObserver(pObserver: IObserverDownload);
begin
  FObservers.Add(pObserver);
end;

procedure TRequisicaoHTTP.ConfigurarRequisicaoHTTP();
begin
  //IdHttp Base
  FIdHttp.AllowCookies                    := True;
  FIdHttp.HandleRedirects                 := True;
  FIdHttp.HTTPOptions                     := [hoKeepOrigProtocol];
  FIdHttp.MaxAuthRetries                  := 3;
  FIdHttp.ProtocolVersion                 := pv1_1;
  FIdHttp.ProxyParams.BasicAuthentication := False;
  FIdHttp.RedirectMaximum                 := 15;

  //IdHttp Request
  FIdHttp.Request.Accept                     := CRequestAccept;
  FIdHttp.Request.BasicAuthentication        := False;
  FIdHttp.Request.CacheControl               := CRequestCacheControl;
  FIdHttp.Request.ContentEncoding            := CRequestContentEncoding;
  FIdHttp.Request.ContentLength              := -1;
  FIdHttp.Request.ContentRangeEnd            := -1;
  FIdHttp.Request.ContentRangeInstanceLength := -1;
  FIdHttp.Request.ContentRangeStart          := -1;
  FIdHttp.Request.ContentType                := CRequestContentType;
  FIdHttp.Request.UserAgent                  := CRequestUserAgent;

  //IdSSLHandler Base
  FIdSSLHandler.IPVersion      := Id_IPv4;
  FIdSSLHandler.MaxLineAction  := maException;
  FIdSSLHandler.MaxLineLength  := 16384;
  FIdSSLHandler.ReadTimeout    := -1;
  FIdSSLHandler.RecvBufferSize := 32768;
  FIdSSLHandler.ReuseSocket    := rsOSDependent;
  FIdSSLHandler.SendBufferSize := 32768;
  FIdSSLHandler.UseNagle       := True;

  //IdSSLHandler Options
  FIdSSLHandler.SSLOptions.Method      := sslvSSLv23;
  FIdSSLHandler.SSLOptions.Mode        := sslmBoth;
  FIdSSLHandler.SSLOptions.SSLVersions := [sslvSSLv2,sslvSSLv3,sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
  FIdSSLHandler.SSLOptions.VerifyMode  := [];

  FIdHttp.IOHandler := FIdSSLHandler;

  FIdHttp.OnWork      := IdHTTPWork;
  FIdHttp.OnWorkBegin := IdHTTPWorkBegin;
  FIdHttp.OnWorkEnd   := IdHTTPWorkEnd;
end;

constructor TRequisicaoHTTP.CreatePrivate();
begin
  inherited Create;
  FIdHttp        := TIdHTTP.Create(nil);
  FIdSSLHandler  := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FDadosDownload := TArquivo.New();
  FObservers     := TList<IObserverDownload>.Create;

  FTempo := Now();
  FPararThread := False;

  ConfigurarRequisicaoHTTP();
end;

destructor TRequisicaoHTTP.Destroy();
begin
  FreeAndNil(FIdHttp);
  FreeAndNil(FIdSSLHandler);
  FreeAndNil(FObservers);

  inherited;
end;

procedure TRequisicaoHTTP.Enviar(pArquivo: IArquivo);
var
  lNomeVerificacao: string;
  lNomeArquivo: string;
  lFileStream: TFileStream;
  I: Integer;
begin
  FDadosDownload.Id         := pArquivo.Id;
  FDadosDownload.IdDatabase := pArquivo.IdDatabase;
  FDadosDownload.Url        := pArquivo.Url;

  lNomeArquivo := TDownloaderUtils.RetornarNomeArquivoRemoto(FDadosDownload.Url);
  lNomeVerificacao := lNomeArquivo;

  while FileExists('..\downloads\' + lNomeVerificacao) do
  begin
    Inc(I);
    lNomeVerificacao := Copy(lNomeArquivo, 1, Pos('.', lNomeArquivo) - 1) + ' (' + I.ToString + ')' + ExtractFileExt(lNomeArquivo);
  end;

  lNomeArquivo := lNomeVerificacao;

  lFileStream := TFileStream.Create('..\downloads\' + lNomeArquivo, fmCreate);
  try
    FIdHTTP.Get(FDadosDownload.Url, lFileStream);
  finally
    FreeAndNil(lFileStream);
  end;
end;

procedure TRequisicaoHTTP.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  FDadosDownload.BytesBaixados := AWorkCount;
  FDadosDownload.Percentual    := Trunc(FDadosDownload.BytesBaixados * 100 / FDadosDownload.BytesTotal);
  FDadosDownload.Finalizado    := False;

  if (SecondsBetween(Now(), FTempo) > 4) then
  begin
    Notificar();
    FTempo := Now();

    Exit();
  end;
end;

procedure TRequisicaoHTTP.IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FDadosDownload.BytesTotal := AWorkCountMax;
end;

procedure TRequisicaoHTTP.IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  FDadosDownload.DataHoraFim := Now();
  FDadosDownload.Percentual  := 100;
  FDadosDownload.Finalizado  := True;

  Notificar();
end;

class function TRequisicaoHTTP.New(): IRequisicaoHTTP;
begin
  Result := TRequisicaoHTTP.CreatePrivate();
end;

procedure TRequisicaoHTTP.Notificar();
var
  lObserver: IObserverDownload;
begin
  for lObserver in FObservers do
  begin
    TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        lObserver.Atualizar(FDadosDownload);
      end
    );
  end;
end;

end.
