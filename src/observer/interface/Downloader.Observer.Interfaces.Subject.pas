unit Downloader.Observer.Interfaces.Subject;

interface

uses
  Downloader.Observer.Interfaces.Observer;

type
  ISubject = interface
    ['{F1998CB0-CF5E-4433-80B9-7F5E49B27BF4}']
    procedure AdicionarObserver(pObserver: IObserverDownload);
    procedure Notificar();
  end;

implementation

end.
