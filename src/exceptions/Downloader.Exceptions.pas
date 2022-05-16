unit Downloader.Exceptions;

interface

uses
  System.SysUtils;

type
  //Erros de banco de dados
  EErroBancoDados               = class(Exception);
  EErroBancoDadosConectar       = class(Exception);
  EErroBancoDadosDesconectar    = class(Exception);
  EErroBancoDadosGravacao       = class(Exception);
  EErroBancoDadosSemRegistros   = class(Exception);
  EErroBancoDadosTabelaInvalida = class(Exception);

implementation

end.
