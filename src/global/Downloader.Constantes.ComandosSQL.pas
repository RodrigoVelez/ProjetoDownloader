unit Downloader.Constantes.ComandosSQL;

interface

const
  CSQLite_GravarArquivo =
    'INSERT INTO logdownload ' +
    '( ' +
    '  url, ' +
    '  datainicio ' +
    ') ' +
    'VALUES ' +
    '( ' +
    '  :url, ' +
    '  :datainicio ' +
    ')';

  CSQLite_AtualizarArquivo =
    'UPDATE logdownload ' +
    'SET ' +
    '  datafim = :datafim ' +
    'WHERE ' +
    '  codigo = :codigo';

  CSQLite_RetornarListaDownloads =
    'SELECT ' +
    '  codigo, ' +
    '  url, ' +
    '  datainicio, ' +
    '  datafim ' +
    'FROM ' +
    '  logdownload';

  CSQLite_RetornarCodigoGravado =
    'SELECT ' +
    '  MAX(codigo) as codigo ' +
    'FROM ' +
    '  logdownload';

implementation

end.
