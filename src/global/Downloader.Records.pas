unit Downloader.Records;

interface

uses
  Downloader.Enum;

type
  TParamConn = record
  private
    FDatabase    : string;
    FUserName    : string;
    FPassword    : string;
    FLockingMode : TTipoLockingMode;
  public
    property Database    : string           read FDatabase    write FDatabase;
    property UserName    : string           read FUserName    write FUserName;
    property Password    : string           read FPassword    write FPassword;
    property LockingMode : TTipoLockingMode read FLockingMode write FLockingMode;
  end;

implementation

end.
