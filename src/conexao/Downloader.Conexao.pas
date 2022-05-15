unit Downloader.Conexao;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  Data.DB,
  Downloader.Records,
  Downloader.Exceptions,
  Downloader.ResourceStr,
  Downloader.Conexao.Interfaces;

type
  TConexao = class(TInterfacedObject, IConexao)
  private
    function GetConexao(): TFDConnection;

    procedure Conectar();
    procedure Desconectar();
    function Connected(): Boolean;
    function RetornarErroFormatado(pMensagem: string): string;
  protected
    FConexao: TFDConnection;
    FDadosConexao: TParamConn;

    procedure ConfiguraConexao(); virtual; abstract;
  public
    constructor Create(pDadosConexao: TParamConn); virtual;
    destructor Destroy(); override;

    property Conexao: TFDConnection read GetConexao write FConexao;
  end;

implementation

{ TConexao }

procedure TConexao.Conectar();
begin
  ConfiguraConexao();

  try
    if not Connected() then
      FConexao.Connected := True;
  except
    on E: Exception do
      raise EErroBancoDadosConectar.Create(RetornarErroFormatado(E.Message));
  end;
end;

function TConexao.Connected(): Boolean;
begin
  Result := FConexao.Connected;
end;

constructor TConexao.Create(pDadosConexao: TParamConn);
begin
  try
    FConexao   := TFDConnection.Create(nil);
    FDadosConexao := pDadosConexao;

    Conectar();
  except
    raise;
  end;
end;

procedure TConexao.Desconectar();
begin
  try
    if Connected() then
      FConexao.Connected := False;
  except
    on E: Exception do
      raise EErroBancoDadosDesconectar.Create(RetornarErroFormatado(E.Message));
  end;
end;

destructor TConexao.Destroy();
begin
  try
    Desconectar();

    FreeAndNil(FConexao);
  except
    raise;
  end;

  inherited;
end;

function TConexao.GetConexao(): TFDConnection;
begin
  Result := FConexao;
end;

function TConexao.RetornarErroFormatado(pMensagem: string): string;
var
  LStr: TStringBuilder;
begin
  LStr := TStringBuilder.Create;
  try
    LStr.Append(rsEgineErrorDesconectar);
    LStr.Append(sLineBreak);
    LStr.Append(sLineBreak);
    LStr.Append('Erro:');
    LStr.Append(sLineBreak);
    LStr.Append(pMensagem);

    Result := LStr.ToString();
  finally
    FreeAndNil(LStr);
  end;
end;

end.
