unit Downloader.Model.RequisicaoHTTP.Factory;

interface

uses
  System.SysUtils,
  Downloader.Enum,
  Downloader.Constantes,
  Download.Model.Interfaces.RequisicaoHTTP,
  Download.Model.RequisicaoHTTP;

type
  TRequisicaoHTTPFactory = class
  private
    constructor CreatePrivate();
  public
    class function GetInstancia(): TRequisicaoHTTPFactory;

    function GetRequisicaoHTTP(): IRequisicaoHTTP;
  end;

implementation

var
  FRequisicaoHTTPFactory: TRequisicaoHTTPFactory;

{ TRequisicaoHTTPFactory }

constructor TRequisicaoHTTPFactory.CreatePrivate();
begin
  inherited Create;
end;

function TRequisicaoHTTPFactory.GetRequisicaoHTTP(): IRequisicaoHTTP;
begin
  Result := TRequisicaoHTTP.New();
end;

class function TRequisicaoHTTPFactory.GetInstancia(): TRequisicaoHTTPFactory;
begin
  if not Assigned(FRequisicaoHTTPFactory) then
    FRequisicaoHTTPFactory := TRequisicaoHTTPFactory.CreatePrivate();

  Result := FRequisicaoHTTPFactory;
end;

initialization
finalization
  FreeAndNil(FRequisicaoHTTPFactory);

end.
