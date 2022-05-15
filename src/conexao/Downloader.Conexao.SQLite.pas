unit Downloader.Conexao.SQLite;

interface

uses
  System.SysUtils,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.Consts,
  Downloader.Records,
  Downloader.Conexao,
  Downloader.Constantes;

type
  TConexaoSQLite = class(TConexao)
  private
    FPhysDriverSQLite: TFDPhysSQLiteDriverLink;
  protected
    procedure ConfiguraConexao(); override;
  public
    constructor Create(AParam: TParamConn); override;
    destructor Destroy(); override;
  end;

implementation

{ TConexaoSQLite }

procedure TConexaoSQLite.ConfiguraConexao();
begin
  //Conexão
  FConexao.DriverName := S_FD_SQLiteId;
  FConexao.LoginPrompt := False;

  //Parâmetros
  FConexao.Params.Values[S_FD_ConnParam_Common_DriverID] := S_FD_SQLiteId;
  FConexao.Params.Values[S_FD_ConnParam_Common_Database] := FDadosConexao.Database;
  FConexao.Params.Values[CParamConnLookingMode]          := CNomeTipoLookingMode[Ord(FDadosConexao.LockingMode)];
end;

constructor TConexaoSQLite.Create(AParam: TParamConn);
begin
  inherited;
  FPhysDriverSQLite := TFDPhysSQLiteDriverLink.Create(nil);
end;

destructor TConexaoSQLite.Destroy;
begin
  FreeAndNil(FPhysDriverSQLite);
  inherited;
end;

end.
