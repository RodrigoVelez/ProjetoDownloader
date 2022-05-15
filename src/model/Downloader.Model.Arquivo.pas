unit Downloader.Model.Arquivo;

interface

uses
  System.SysUtils,
  Downloader.Model.Interfaces.Arquivo;

type
  TArquivo = class(TInterfacedObject, IArquivo)
  private
    FId             : Integer;
    FIdDatabase     : Integer;
    FUrl            : string;
    FDataHoraInicio : TDateTime;
    FDataHoraFim    : TDateTime;
    FBytesBaixados  : Int64;
    FBytesTotal     : Int64;
    FFinalizado     : Boolean;
    FPercentual      : Integer;

    function GetId(): Integer;
    function GetIdDatabase(): Integer;
    function GetUrl(): string;
    function GetDataHoraInicio(): TDateTime;
    function GetDataHoraFim(): TDateTime;
    function GetBytesBaixados(): Int64;
    function GetBytesTotal(): Int64;
    function GetFinalizado(): Boolean;
    function GetPercentual(): Integer;

    procedure SetId(const Value: Integer);
    procedure SetIdDatabase(const Value: Integer);
    procedure SetUrl(const Value: string);
    procedure SetDataHoraInicio(const Value: TDateTime);
    procedure SetDataHoraFim(const Value: TDateTime);
    procedure SetBytesBaixados(const Value: Int64);
    procedure SetBytesTotal(const Value: Int64);
    procedure SetFinalizado(const Value: Boolean);
    procedure SetPercentual(const Value: Integer);

    procedure InicializaCampos();
    constructor CreatePrivate();
  public
    class function New(): IArquivo;

    property Id             : Integer   read GetId             write SetId;
    property IdDatabase     : Integer   read GetIdDatabase     write SetIdDatabase;
    property Url            : string    read GetUrl            write SetUrl;
    property DataHoraInicio : TDateTime read GetDataHoraInicio write SetDataHoraInicio;
    property DataHoraFim    : TDateTime read GetDataHoraFim    write SetDataHoraFim;
    property BytesBaixados  : Int64     read GetBytesBaixados  write SetBytesBaixados;
    property BytesTotal     : Int64     read GetBytesTotal     write SetBytesTotal;
    property Finalizado     : Boolean   read GetFinalizado     write SetFinalizado;
    property Percentual     : Integer   read GetPercentual     write SetPercentual;
  end;

implementation

{ TArquivo }

function TArquivo.GetId(): Integer;
begin
  Result := FId;
end;

function TArquivo.GetIdDatabase: Integer;
begin
  Result := FIdDatabase;
end;

function TArquivo.GetPercentual(): Integer;
begin
  Result := FPercentual;
end;

function TArquivo.GetUrl(): string;
begin
  Result := FUrl;
end;

function TArquivo.GetDataHoraInicio(): TDateTime;
begin
  Result := FDataHoraInicio;
end;

function TArquivo.GetDataHoraFim(): TDateTime;
begin
  Result := FDataHoraFim;
end;

function TArquivo.GetBytesBaixados(): Int64;
begin
  Result := FBytesBaixados;
end;

function TArquivo.GetBytesTotal(): Int64;
begin
  Result := FBytesTotal;
end;

function TArquivo.GetFinalizado: Boolean;
begin
  Result := FFinalizado;
end;

procedure TArquivo.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TArquivo.SetIdDatabase(const Value: Integer);
begin
  FIdDatabase := Value;
end;

procedure TArquivo.SetPercentual(const Value: Integer);
begin
  FPercentual := Value;
end;

procedure TArquivo.SetUrl(const Value: string);
begin
  FUrl := Value;
end;

procedure TArquivo.SetDataHoraInicio(const Value: TDateTime);
begin
  FDataHoraInicio := Value;
end;

procedure TArquivo.SetDataHoraFim(const Value: TDateTime);
begin
  FDataHoraFim := Value;
end;

procedure TArquivo.SetBytesBaixados(const Value: Int64);
begin
  FBytesBaixados := Value;
end;

procedure TArquivo.SetBytesTotal(const Value: Int64);
begin
  FBytesTotal := Value;
end;

procedure TArquivo.SetFinalizado(const Value: Boolean);
begin
  FFinalizado := Value;
end;

procedure TArquivo.InicializaCampos();
begin
  FId             := 0;
  FIdDatabase     := 0;
  FUrl            := '';
  FDataHoraInicio := Now;
  FDataHoraFim    := 0;
  FBytesBaixados  := 0;
  FBytesTotal     := 0;
  FFinalizado     := False;
  FPercentual     := 0;
end;

constructor TArquivo.CreatePrivate();
begin
  inherited Create;

  InicializaCampos();
end;

class function TArquivo.New(): IArquivo;
begin
  Result := Self.CreatePrivate();
end;

end.
