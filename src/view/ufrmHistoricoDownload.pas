unit ufrmHistoricoDownload;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.StrUtils,
  System.DateUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Grids,
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Controller.Interfaces.Arquivo,
  Downloader.Controller.Arquivo;

type
  TfrmHistoricoDownload = class(TForm)
    pnlTitulo: TPanel;
    pnlDados: TPanel;
    sgridTitulo: TStringGrid;
    sgridListaDownloads: TStringGrid;
    pnlRodape: TPanel;
    btnFechar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    procedure InicializarGrid();
    procedure CarregarLista();
  public
    { Public declarations }
  end;

var
  frmHistoricoDownload: TfrmHistoricoDownload;

implementation

{$R *.dfm}

procedure TfrmHistoricoDownload.btnFecharClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmHistoricoDownload.CarregarLista();
var
  I, L: Integer;
  lLista: TList<IArquivo>;
  lController: IControllerArquivo;
begin
  lController := TControllerArquivo.New();
  lLista      := lController.RetornarHistoricoListaDownloadJaExecutados();
  try
    if lLista.Count > 0 then
      sgridListaDownloads.RowCount := lLista.Count;

    for L := 0 to Pred(lLista.Count) do
    begin
      I := 0;
      sgridListaDownloads.Cells[I, L] := IntToStr(lLista[L].Id); Inc(I); // 0 - Código
      sgridListaDownloads.Cells[I, L] := lLista[L].Url;  Inc(I); // 1 - Url
      sgridListaDownloads.Cells[I, L] := FormatDateTime('DD/MM/YYYY hh:mm:ss', lLista[L].DataHoraInicio); Inc(I); // 2 - Data de Início
      sgridListaDownloads.Cells[I, L] := IfThen(lLista[L].DataHoraFim = 0, '', FormatDateTime('DD/MM/YYYY hh:mm:ss', lLista[L].DataHoraFim)); // 3 - Data de Fim
    end;
  finally
    FreeAndNil(lLista);
  end;
end;

procedure TfrmHistoricoDownload.FormShow(Sender: TObject);
begin
  InicializarGrid();
  CarregarLista();
end;

procedure TfrmHistoricoDownload.InicializarGrid();
var
  I: Integer;
begin
  sgridTitulo.RowCount  := 2;
  sgridTitulo.ColCount  := 4;
  sgridTitulo.FixedRows := 1;

  sgridListaDownloads.RowCount  := 1;
  sgridListaDownloads.ColCount  := 4;
  sgridListaDownloads.FixedRows := 0;

  I := 0;
  sgridTitulo.Cells[I, 0] := 'Código';         sgridListaDownloads.Cells[I, 0] := ''; Inc(I);
  sgridTitulo.Cells[I, 0] := 'Url';            sgridListaDownloads.Cells[I, 0] := ''; Inc(I);
  sgridTitulo.Cells[I, 0] := 'Data de Início'; sgridListaDownloads.Cells[I, 0] := ''; Inc(I);
  sgridTitulo.Cells[I, 0] := 'Data de Fim';    sgridListaDownloads.Cells[I, 0] := '';

  I := 0;
  sgridTitulo.ColWidths[I] := 80;  sgridListaDownloads.ColWidths[I] := 80;  Inc(I); //Codigo
  sgridTitulo.ColWidths[I] := 380; sgridListaDownloads.ColWidths[I] := 380; Inc(I); //Url
  sgridTitulo.ColWidths[I] := 120; sgridListaDownloads.ColWidths[I] := 120; Inc(I); //Data de Início
  sgridTitulo.ColWidths[I] := 120; sgridListaDownloads.ColWidths[I] := 120;         //Data de Fim
end;

end.
