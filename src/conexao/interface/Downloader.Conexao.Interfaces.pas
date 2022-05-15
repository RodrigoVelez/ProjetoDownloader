unit Downloader.Conexao.Interfaces;

interface

uses
  FireDAC.Comp.Client;

type
  IConexao = interface
    ['{8820D406-9AE1-423D-A51F-804E6213C180}']
    function GetConexao(): TFDConnection;

    procedure Conectar();
    procedure Desconectar();
    function Connected(): Boolean;

    property Conexao: TFDConnection read GetConexao;
  end;

implementation

end.
