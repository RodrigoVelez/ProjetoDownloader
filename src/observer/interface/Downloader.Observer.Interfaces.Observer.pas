unit Downloader.Observer.Interfaces.Observer;

interface

uses
  Downloader.Model.Interfaces.Arquivo;

type
  IObserverDownload = interface
    ['{1F68EDF2-22E6-4694-BF92-4B30EBC4E92C}']
    procedure Atualizar(pArquivo: IArquivo);
  end;

implementation

end.
