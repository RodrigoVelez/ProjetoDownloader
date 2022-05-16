unit Downloader.DAO.Interfaces.ArquivoDAO;

interface

uses
  System.Generics.Collections,
  Downloader.Model.Interfaces.Arquivo;

type
  IArquivoDAO = interface
    ['{80E8BE00-45C9-401C-A87F-CEB78DF1FD35}']
    procedure Gravar(pArquivo: IArquivo);
    procedure Atualizar(pArquivo: IArquivo);
    procedure RetornarListaDownloads(pLista: TList<IArquivo>);
    function RetornarCodigoDownloadGravado(): Integer;
  end;

implementation

end.
