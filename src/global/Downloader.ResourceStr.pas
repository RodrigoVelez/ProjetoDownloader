unit Downloader.ResourceStr;

interface

resourcestring
  rsMensagemSemDados = 'Digite uma url para fazer o download';
  rsMensagemDownloadEmAndamento = 'Existe um download em andamento, deseja interrompe-lo?';

  //Erros de Banco de Dados (Grupo: EDB)
  rsEgineErrorConectar            = 'EDB.001-Problema ao conectar ao banco de dados. Favor verificar par�metros de conex�o.';
  rsEgineErrorDesconectar         = 'EDB.002-Problema ao desconectar ao banco de dados.';
  rsEgineErrorekOther             = 'EDB.003-Erro desconhecido';
  rsEgineErrorekNoDataFound       = 'EDB.004-Nenhum registro encontrado';
  rsEgineErrorekTooManyRows       = 'EDB.005-Mais registro encontrado que o esperado';
  rsEgineErrorekRecordLocked      = 'EDB.006-Registro bloqueado ou outra transa��o';
  rsEgineErrorekUKViolated        = 'EDB.007-Este registro j� existe no banco de dados';
  rsEgineErrorekFKViolated        = 'EDB.008-Existe um relacionamento que impossibilita atualizar este registro';
  rsEgineErrorekObjNotExists      = 'EDB.009-Objeto de banco de dados n�o encontrado';
  rsEgineErrorekUserPwdInvalid    = 'EDB.010-Password inv�lido';
  rsEgineErrorekUserPwdExpired    = 'EDB.011-Password expirado';
  rsEgineErrorekUserPwdWillExpire = 'EDB.012-Pasword ir� expirar';
  rsEgineErrorekCmdAborted        = 'EDB.013-Comando abortado';
  rsEgineErrorekServerGone        = 'EDB.014-Servidor de banco de dados n�o est� acess�vel';
  rsEgineErrorekServerOutput      = 'EDB.015-Texto de sa�da de dados do servidor';
  rsEgineErrorekArrExecMalfunc    = 'EDB.016-Uma requisi��o de atualiza��o em massa falhou por causa de falha do sistema ou de alguma integridade de banco de dados';
  rsEgineErrorekInvalidParams     = 'EDB.017-Par�metro(s) inv�lido(s)';
  rsTabelaInvalida                = 'EDB.018-Consulta inv�lida.';

  //Erros de DML de banco de dados
  rsDMLErrorInsercaoRowsAffectedZero    = 'EG.001-Nenhum registro foi gravado.';
  rsDMLErrorAtualizacaoRowsAffectedZero = 'EG.002-Nenhum registro foi atualizado.';
  rsDMLErrorNenhumRegistroEncontrado    = 'EG.003-Nenhum registro foi encontrado.';

implementation

end.
