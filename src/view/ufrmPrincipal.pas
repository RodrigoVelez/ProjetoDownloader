unit ufrmPrincipal;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.UITypes,
  System.StrUtils,
  System.Generics.Collections,
  Vcl.Dialogs,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Data.DB,
  Datasnap.DBClient,
  ufrmHistoricoDownload,
  ufrmInfoDownloadCorrente,
  Downloader.ResourceStr,
  Downloader.Controller.Arquivo,
  Downloader.Controller.Interfaces.Arquivo,
  Downloader.Model.Interfaces.Arquivo,
  Downloader.Observer.Interfaces.Observer;

type
  TfrmPrincipal = class(TForm, IObserverDownload)
    pnlEntradaDados: TPanel;
    edtLinkDownload: TLabeledEdit;
    btnIniciarDownload: TBitBtn;
    pnlOperacoes: TPanel;
    btnPararDownload: TBitBtn;
    btnInfoDownload: TBitBtn;
    grdListaDownload: TDBGrid;
    cdsListaDownload: TClientDataSet;
    cdsListaDownloadID: TIntegerField;
    cdsListaDownloadURL: TStringField;
    cdsListaDownloadDATA_INICIO: TDateTimeField;
    cdsListaDownloadDATA_FIM: TDateTimeField;
    dsListaDownload: TDataSource;
    btnHistoricoDownloads: TBitBtn;
    cdsListaDownloadPERCENTUAL: TIntegerField;
    cdsListaDownloadBYTES_BAIXADOS: TLargeintField;
    cdsListaDownloadBYTES_TOTAL: TLargeintField;
    cdsListaDownloadFINALIZADO: TStringField;
    pnlRodape: TPanel;
    btnFechar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnIniciarDownloadClick(Sender: TObject);
    procedure grdListaDownloadDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnHistoricoDownloadsClick(Sender: TObject);
    procedure btnInfoDownloadClick(Sender: TObject);
    procedure btnPararDownloadClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FController: IControllerArquivo;
    procedure IniciarDownload();
    procedure AtualizarGridListaExecucao();
    procedure Atualizar(pArquivo: IArquivo);
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.Atualizar(pArquivo: IArquivo);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    var
      I: Integer;
    begin
      for I := 0 to cdsListaDownload.RecordCount - 1 do
      begin
        if cdsListaDownloadID.AsInteger = pArquivo.Id then
        begin
          cdsListaDownload.Edit();
          cdsListaDownloadDATA_FIM.AsDateTime  := pArquivo.DataHoraFim;
          cdsListaDownloadBYTES_BAIXADOS.Value := pArquivo.BytesBaixados;
          cdsListaDownloadBYTES_TOTAL.Value    := pArquivo.BytesTotal;
          cdsListaDownloadPERCENTUAL.Value     := pArquivo.Percentual;
          cdsListaDownloadFINALIZADO.AsString  := IfThen(pArquivo.Finalizado, 'S', 'N');
          cdsListaDownload.Post();

          Break;
        end;
      end;
    end
  );
end;

procedure TfrmPrincipal.AtualizarGridListaExecucao();
var
  lItem: IArquivo;
  lLista: TList<IArquivo>;
begin
  cdsListaDownload.DisableControls();

  lLista := FController.RetornarListaDownloasEmExecucao();

  if lLista.Count > 0 then
  begin
    cdsListaDownload.EmptyDataSet();

    for lItem in lLista do
    begin
      cdsListaDownload.Append();
      cdsListaDownloadID.AsInteger           := lItem.Id;
      cdsListaDownloadURL.AsString           := lItem.Url;
      cdsListaDownloadDATA_INICIO.AsDateTime := lItem.DataHoraInicio;
      cdsListaDownloadDATA_FIM.AsDateTime    := lItem.DataHoraFim;
      cdsListaDownloadBYTES_BAIXADOS.Value   := lItem.BytesBaixados;
      cdsListaDownloadBYTES_TOTAL.Value      := lItem.BytesTotal;
      cdsListaDownloadFINALIZADO.AsString    := IfThen(lItem.Finalizado, 'S', 'N');
      cdsListaDownload.Post();
    end;
  end;

  cdsListaDownload.EnableControls();
end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmPrincipal.btnHistoricoDownloadsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmHistoricoDownload, frmHistoricoDownload);
  try
    frmHistoricoDownload.ShowModal();
  finally
    FreeAndNil(frmHistoricoDownload);
  end;
end;

procedure TfrmPrincipal.btnInfoDownloadClick(Sender: TObject);
begin
  if cdsListaDownload.RecordCount > 0 then
  begin
    Application.CreateForm(TfrmInfoDownloadCorrente, frmInfoDownloadCorrente);
    try
      frmInfoDownloadCorrente.DadosArquivo.Id             := cdsListaDownloadID.Value;
      frmInfoDownloadCorrente.DadosArquivo.Url            := cdsListaDownloadURL.AsString;
      frmInfoDownloadCorrente.DadosArquivo.BytesBaixados  := cdsListaDownloadBYTES_BAIXADOS.Value;
      frmInfoDownloadCorrente.DadosArquivo.BytesTotal     := cdsListaDownloadBYTES_TOTAL.Value;
      frmInfoDownloadCorrente.DadosArquivo.DataHoraInicio := cdsListaDownloadDATA_INICIO.Value;
      frmInfoDownloadCorrente.DadosArquivo.DataHoraFim    := cdsListaDownloadDATA_FIM.Value;
      frmInfoDownloadCorrente.DadosArquivo.Percentual     := cdsListaDownloadPERCENTUAL.Value;
      frmInfoDownloadCorrente.ShowModal();
    finally
      FreeAndNil(frmInfoDownloadCorrente);
    end;
  end;
end;

procedure TfrmPrincipal.btnIniciarDownloadClick(Sender: TObject);
begin
  if (Trim(edtLinkDownload.Text) <> EmptyStr) then
  begin
    IniciarDownload();
    AtualizarGridListaExecucao();
  end
  else
  begin
    MessageDlg(rsMensagemSemDados, mtError, [mbOK], 0);
    edtLinkDownload.SetFocus;
  end;
end;

procedure TfrmPrincipal.btnPararDownloadClick(Sender: TObject);
begin
  FController.PararDownloadEmExecucao(cdsListaDownloadID.AsInteger);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FController.ExisteDownloadEmExecucao() then
  begin
    if MessageDlg(rsMensagemDownloadEmAndamento, mtConfirmation, [mbYes,mbNo], 0, mbYes)  = mrYes then
    begin
      FController.PararTodosDownloadsEmExecucao();
    end;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FController := TControllerArquivo.New();
  FController.AdicionarObserver(Self);
  cdsListaDownload.CreateDataSet();
  cdsListaDownload.Open();
end;

procedure TfrmPrincipal.grdListaDownloadDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  lRect2: Integer;
  lPercent: Integer;
  lTexto: string;
begin
  if Column.FieldName = 'PERCENTUAL' then
  begin
    if (cdsListaDownload.IsEmpty) or (cdsListaDownloadBYTES_TOTAL.Value <= 0) then
      Exit();

    //Retangulo 1 (Parte não preenchida)
    grdListaDownload.Canvas.Brush.Color := clWindow;
    grdListaDownload.Canvas.Pen.Color := clRed;
    grdListaDownload.Canvas.Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + Column.Width - 2, Rect.Top + 15);

    //Retangulo 2 (Parte preenchida)
    lPercent := cdsListaDownloadPERCENTUAL.AsInteger;
    lRect2 := Trunc((Column.Width * lPercent) / 100);
    grdListaDownload.Canvas.Brush.Color := clLime;
    grdListaDownload.Canvas.Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + lRect2 - 2, Rect.Top + 15);

    //Texto
    lTexto := lPercent.ToString + '%';
    grdListaDownload.Canvas.Brush.Style := bsClear;
    grdListaDownload.Canvas.Font.Size := 7;
    grdListaDownload.Canvas.TextOut((Rect.Left + Column.Width div 2) - (grdListaDownload.Canvas.TextWidth(lTexto) div 2), Rect.Top + 3, lTexto);
  end;
end;

procedure TfrmPrincipal.IniciarDownload();
begin
  FController.AdicionarDownloadListaDeExecucao(edtLinkDownload.Text);
end;

end.
