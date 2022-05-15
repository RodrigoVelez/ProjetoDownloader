unit Downloader.Constantes;

interface

const
  //Parâmetros de conexão
  CParamConnDataBase          = 'Database';
  CParamConnUserName          = 'UserName';
  CParamConnPassword          = 'Password';
  CParamConnServer            = 'Server';
  CParamConnPorta             = 'Port';
  CParamConnVendorLib         = 'VendorLib';
  CParamConnODBCDriver        = 'ODBCDriver';
  CParamConnODBCDataSource    = 'ODBCDataSource';
  CParamConnODBCNumericFormat = 'ODBCNumericFormat';
  CParamConnLookingMode       = 'LookingMode';

  //Arquivo de inicialização
  CIniFileNameDadosConexao = 'config.ini';
  CIniFileChave            = 'DB_SQLite';
  CIniFileValorServidor    = 'Servidor';
  CIniFileValorPath        = 'Path';

  //Nome dos banco de dados
  CNomeBancoDadosSQLite = 'SPDownloader.db';

  //RequisicaoHTTP
  CRequestAccept = 'text/html,application/xhtml+xml,application/xml,application/octet-stream;q=0.9,*/*;q=0.8';
  CRequestCacheControl = 'no-cache';
  CRequestContentEncoding = 'utf-8';
  CRequestContentType = 'application/octet-stream';
  CRequestUserAgent = 'Mozilla/3.0 (compatible; Indy Library)';
  CRequestConexaoHTTPS = 'https';

  CNomeTipoLookingMode : array[0..1] of string = ('Normal','Exclusive');

implementation

end.
