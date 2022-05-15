unit Downloader.Utils;

interface

uses
  System.SysUtils,
  IdURI;

type
  TDownloaderUtils = class
  public
    class function RetornarNomeArquivoRemoto(const pUrl: string): string;
  end;

implementation

{ TDownloaderUtils }

class function TDownloaderUtils.RetornarNomeArquivoRemoto(const pUrl: string): string;
var
  lIdURI: TIdURI;
begin
  lIdURI := TIdURI.Create(pUrl);
  try
    Result := lIdURI.Document;

    if Result.IsEmpty() then
      Result := 'Download.exe';

    if ExtractFileExt(Result) = '' then
      Result := Result + '.exe';
  finally
    FreeAndNil(lIdURI);
  end;
end;

end.
