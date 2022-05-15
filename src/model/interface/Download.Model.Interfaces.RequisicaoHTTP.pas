unit Download.Model.Interfaces.RequisicaoHTTP;

interface

uses
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Observer.Interfaces.Subject;

type
  IRequisicaoHTTP = interface(ISubject)
    ['{D487981D-7E86-49FF-ADE9-8E04DF25EE7A}']

    procedure Enviar(pArquivo: IArquivo);
  end;

implementation

end.
