unit Downloader.Model.Interfaces.Arquivo;

interface

type
  IArquivo = interface
    ['{109088F8-AF82-4D3F-865D-824B98063677}']

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

end.
