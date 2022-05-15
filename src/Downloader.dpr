program Downloader;

uses
  FastMM4,
  Vcl.Forms,
  ufrmPrincipal in 'view\ufrmPrincipal.pas' {frmPrincipal},
  Downloader.ResourceStr in 'global\Downloader.ResourceStr.pas',
  Downloader.Enum in 'global\Downloader.Enum.pas',
  Downloader.Constantes in 'global\Downloader.Constantes.pas',
  Downloader.Conexao.Interfaces in 'conexao\interface\Downloader.Conexao.Interfaces.pas',
  Downloader.Conexao in 'conexao\Downloader.Conexao.pas',
  Downloader.Records in 'global\Downloader.Records.pas',
  Downloader.Exceptions in 'exceptions\Downloader.Exceptions.pas',
  Downloader.Conexao.Factory in 'conexao\Downloader.Conexao.Factory.pas',
  Downloader.Conexao.SQLite in 'conexao\Downloader.Conexao.SQLite.pas',
  Downloader.DAO.Interfaces.ArquivoDAO in 'dao\interface\Downloader.DAO.Interfaces.ArquivoDAO.pas',
  Downloader.Model.Interfaces.Arquivo in 'model\interface\Downloader.Model.Interfaces.Arquivo.pas',
  Downloader.Model.Arquivo in 'model\Downloader.Model.Arquivo.pas',
  Downloader.DAO.ArquivoDAO in 'dao\Downloader.DAO.ArquivoDAO.pas',
  Downloader.Constantes.ComandosSQL in 'global\Downloader.Constantes.ComandosSQL.pas',
  Downloader.Controller.Interfaces.Arquivo in 'controller\interface\Downloader.Controller.Interfaces.Arquivo.pas',
  Downloader.Controller.Arquivo in 'controller\Downloader.Controller.Arquivo.pas',
  ufrmHistoricoDownload in 'view\ufrmHistoricoDownload.pas' {frmHistoricoDownload},
  Download.Model.Interfaces.RequisicaoHTTP in 'model\interface\Download.Model.Interfaces.RequisicaoHTTP.pas',
  Download.Model.RequisicaoHTTP in 'model\Download.Model.RequisicaoHTTP.pas',
  Downloader.Model.RequisicaoHTTP.Factory in 'model\Downloader.Model.RequisicaoHTTP.Factory.pas',
  Downloader.Observer.Interfaces.Observer in 'observer\interface\Downloader.Observer.Interfaces.Observer.pas',
  Downloader.Observer.Interfaces.Subject in 'observer\interface\Downloader.Observer.Interfaces.Subject.pas',
  ufrmInfoDownloadCorrente in 'view\ufrmInfoDownloadCorrente.pas' {frmInfoDownloadCorrente},
  Downloader.Utils in 'global\Downloader.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Downloader';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmInfoDownloadCorrente, frmInfoDownloadCorrente);
  Application.Run;
end.
