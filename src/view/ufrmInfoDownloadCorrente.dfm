object frmInfoDownloadCorrente: TfrmInfoDownloadCorrente
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmInfoDownloadCorrente'
  ClientHeight = 213
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDados: TPanel
    Left = 0
    Top = 41
    Width = 433
    Height = 131
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    ExplicitLeft = -99
    ExplicitTop = 20
    ExplicitWidth = 734
    ExplicitHeight = 279
    DesignSize = (
      433
      131)
    object lblNomeArquivo: TLabel
      Left = 8
      Top = 6
      Width = 419
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblNomeArquivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object lblBytesBaixados: TLabel
      Left = 8
      Top = 27
      Width = 419
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblBytesBaixados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object lblBytesTotal: TLabel
      Left = 8
      Top = 48
      Width = 419
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblBytesTotal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object lblPercentual: TLabel
      Left = 8
      Top = 111
      Width = 419
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblPercentual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object lblDataHoraFim: TLabel
      Left = 8
      Top = 90
      Width = 419
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblDataHoraFim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object lblDataHoraInicio: TLabel
      Left = 8
      Top = 69
      Width = 419
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblDataHoraInicio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Informa'#231#245'es do download corrente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = -99
    ExplicitWidth = 734
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 172
    Width = 433
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    ExplicitLeft = -99
    ExplicitTop = 258
    ExplicitWidth = 734
    DesignSize = (
      433
      41)
    object btnFechar: TButton
      Left = 125
      Top = 6
      Width = 182
      Height = 28
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
      ExplicitWidth = 73
    end
  end
end
