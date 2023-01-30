unit uController.ServerConnection;

interface

uses
  IdTCPClient,
  IdGlobal,
  SysUtils;

type
  TServerStatus = (ssConnected, ssDisconnected, ssError);

  TServerConnectionChecker = class(TObject)
  private
    FServerIP: string;
    FServerPort: Integer;
    FSocket: TIdTCPClient;
    FServerStatus: TServerStatus;
    procedure Connect;
    procedure Disconnect;
  public
    constructor Create(AServerIP: string; AServerPort: Integer);
    destructor Destroy; override;
    property ServerStatus: TServerStatus read FServerStatus;
    function Check: TServerStatus;
  end;

implementation

constructor TServerConnectionChecker.Create(AServerIP: string;
  AServerPort: Integer);
begin
  inherited Create;
  FServerIP := AServerIP;
  FServerPort := AServerPort;
  FSocket := TIdTCPClient.Create(nil);
  FServerStatus := ssDisconnected;
end;

destructor TServerConnectionChecker.Destroy;
begin
  FSocket.Free;
  inherited;
end;

procedure TServerConnectionChecker.Connect;
begin
  FSocket.Host := FServerIP;
  FSocket.Port := FServerPort;
  try
    FSocket.Connect;
    if FSocket.Connected then
      FServerStatus := ssConnected
    else
      FServerStatus := ssError;
  except
    FServerStatus := ssError;
  end;
end;

procedure TServerConnectionChecker.Disconnect;
begin
  FSocket.Disconnect;
  FServerStatus := ssDisconnected;
end;

function TServerConnectionChecker.Check: TServerStatus;
begin
  if FServerStatus = ssDisconnected then
    Connect;
  Result := FServerStatus;
end;

end.
