object frmHistoricoDownload: TfrmHistoricoDownload
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 361
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 734
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Hist'#243'rico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object pnlDados: TPanel
    Left = 0
    Top = 41
    Width = 734
    Height = 279
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object sgridTitulo: TStringGrid
      Left = 2
      Top = 2
      Width = 730
      Height = 25
      ParentCustomHint = False
      Align = alTop
      BorderStyle = bsNone
      Color = clBtnFace
      ColCount = 4
      Ctl3D = True
      DoubleBuffered = False
      DrawingStyle = gdsGradient
      FixedColor = cl3DLight
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = False
      TabOrder = 0
      ColWidths = (
        64
        65
        64
        63)
    end
    object sgridListaDownloads: TStringGrid
      Left = 2
      Top = 27
      Width = 730
      Height = 250
      ParentCustomHint = False
      Align = alClient
      BorderStyle = bsNone
      Color = clBtnFace
      ColCount = 4
      Ctl3D = True
      DefaultRowHeight = 21
      DoubleBuffered = False
      DrawingStyle = gdsGradient
      FixedColor = cl3DLight
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = False
      TabOrder = 1
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 320
    Width = 734
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    DesignSize = (
      734
      41)
    object btnFechar: TButton
      Left = 290
      Top = 6
      Width = 153
      Height = 28
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
end
