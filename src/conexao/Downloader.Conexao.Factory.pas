unit Downloader.Conexao.Factory;

interface

uses
  System.SysUtils,
  System.IniFiles,
  Downloader.Enum,
  Downloader.Records,
  Downloader.Constantes,
  Downloader.Conexao.SQLite,
  Downloader.Conexao.Interfaces;

type
  TConexaoFactory = class
  private
    FTipoConexao: TTipoConexao;
    FDadosConexao : TParamConn;
    procedure CarregaParam();
    constructor CreatePrivate();
  public
    class function GetInstancia(): TConexaoFactory;

    function GetConexao(const ATipo: TTipoConexao = tcSQLite): IConexao;
  end;

implementation

var
  FConexaoFactory: TConexaoFactory;

{ TConexaoFactory }

procedure TConexaoFactory.CarregaParam();
var
  lIniFile: TIniFile;
begin
  lIniFile := TIniFile.Create('..\config\' + CIniFileNameDadosConexao);

  try
    case FTipoConexao of
      tcSQLite:
      begin
        FDadosConexao.Database := lIniFile.ReadString(CIniFileChave, CIniFileValorPath, ExtractFilePath(ParamStr(0))) + CNomeBancoDadosSQLite;
        FDadosConexao.LockingMode := tlmNormal;
      end;
    end;
  finally
    FreeAndNil(lIniFile);
  end;
end;

constructor TConexaoFactory.CreatePrivate();
begin
  inherited Create;

  CarregaParam();
end;

function TConexaoFactory.GetConexao(const ATipo: TTipoConexao): IConexao;
begin
  FTipoConexao := ATipo;

  case ATipo of
    tcSQLite : Result := TConexaoSQLite.Create(FDadosConexao);
  end;
end;

class function TConexaoFactory.GetInstancia(): TConexaoFactory;
begin
  if not Assigned(FConexaoFactory) then
    FConexaoFactory := TConexaoFactory.CreatePrivate();

  Result := FConexaoFactory;
end;

initialization
finalization
  FreeAndNil(FConexaoFactory);

end.
