unit Downloader.Controller.Interfaces.Arquivo;

interface

uses
  System.Generics.Collections,
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Observer.Interfaces.Subject;

type
  IControllerArquivo = interface(ISubject)
    ['{5BA56B61-66B1-4D01-8CDB-0A754D784F90}']

    function RetornarHistoricoListaDownloadJaExecutados(): TList<IArquivo>;
    function RetornarListaDownloasEmExecucao(): TList<IArquivo>;

    procedure AdicionarDownloadListaDeExecucao(const pUrl: string);
    procedure PersistirDownloadDatabase(pArquivo: IArquivo);
    procedure AtualizarDownloadDatabase(pArquivo: IArquivo);

    function ExisteDownloadEmExecucao(): Boolean;
    procedure PararDownloadEmExecucao(const pId: Integer);
    procedure PararTodosDownloadsEmExecucao();
  end;

implementation

end.
