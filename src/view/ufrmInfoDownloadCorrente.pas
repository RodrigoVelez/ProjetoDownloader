unit ufrmInfoDownloadCorrente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Downloader.Utils,
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Model.Arquivo;

type
  TfrmInfoDownloadCorrente = class(TForm)
    pnlDados: TPanel;
    pnlTitulo: TPanel;
    pnlRodape: TPanel;
    btnFechar: TButton;
    lblNomeArquivo: TLabel;
    lblBytesBaixados: TLabel;
    lblBytesTotal: TLabel;
    lblPercentual: TLabel;
    lblDataHoraFim: TLabel;
    lblDataHoraInicio: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDadosArquivo: IArquivo;

    function RetornaKiloBytes(ValorAtual: real): string;
  public
    property DadosArquivo: IArquivo read FDadosArquivo write FDadosArquivo;
  end;

var
  frmInfoDownloadCorrente: TfrmInfoDownloadCorrente;

implementation

{$R *.dfm}

procedure TfrmInfoDownloadCorrente.btnFecharClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmInfoDownloadCorrente.FormCreate(Sender: TObject);
begin
  FDadosArquivo := TArquivo.New();
end;

procedure TfrmInfoDownloadCorrente.FormShow(Sender: TObject);
begin
  lblNomeArquivo.Caption    := 'Arquivo..: ' + TDownloaderUtils.RetornarNomeArquivoRemoto(FDadosArquivo.Url);
  lblBytesBaixados.Caption  := 'Baixados.: ' + RetornaKiloBytes(FDadosArquivo.BytesBaixados);
  lblBytesTotal.Caption     := 'Total....: ' + RetornaKiloBytes(FDadosArquivo.BytesTotal);
  lblDataHoraInicio.Caption := 'Início...: ' + FormatDateTime('DD/MM/YYYY hh:mm:ss', FDadosArquivo.DataHoraInicio);
  lblDataHoraFim.Caption    := 'Fim......: ' + IfThen(FDadosArquivo.DataHoraFim = 0, '', FormatDateTime('DD/MM/YYYY hh:mm:ss', FDadosArquivo.DataHoraFim));
  lblPercentual.Caption     := 'Progresso: ' +FDadosArquivo.Percentual.ToString + '%';
end;

function TfrmInfoDownloadCorrente.RetornaKiloBytes(ValorAtual: real): string;
const
  K = Int64(1024);
  M = K * K;
  G = K * M;
  T = K * G;
begin
  if ValorAtual < K then
    Result := Format('%f bytes', [ValorAtual])
  else
  if ValorAtual < M then
    Result := Format('%f KB', [ValorAtual / K])
  else
  if ValorAtual < G then
    Result := Format('%f MB', [ValorAtual / M])
  else
  if ValorAtual < T then
    Result := Format('%f GB', [ValorAtual / G])
  else
    Result := Format('%f TB', [ValorAtual / T]);
end;

end.
