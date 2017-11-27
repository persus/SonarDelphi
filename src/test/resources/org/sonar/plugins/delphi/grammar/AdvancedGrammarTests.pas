{===============================================================================

  Author     : remy.loy
  Date       : 06.02.2007
  Description:

===============================================================================}
unit AdvancedGrammarTests;

interface

uses
  ClassTColumnLayoutControllerTypes,
  graphics;

type
  TErrorCallback = procedure(const AMessage: string) of object;

  // TSafeEvent
  
  TSafeEvent = class
  private
    FOnError: TErrorCallback;
    
  protected
    function Assigned: Boolean; virtual; abstract;
    procedure OnTrigger(Sender: TObject); virtual; abstract;
    
    procedure ShowDialog(const AMessage: string);

  public
    constructor Create;
    procedure Trigger(Sender: TObject);

    property OnError: TErrorCallback read FOnError write FOnError;
  end;

  // TDataEvent

  TListDataEvent = class(TSafeEvent)
  protected
    function Assigned: Boolean; override;
    procedure OnTrigger(Sender: TObject); override;

  public
     ID: string;
     Column: TObject;
     Row: Integer;
     Callback: TListData;
  end;

  // TGetRowCountEvent
  
  TGetRowCountEvent = class(TSafeEvent)
  protected
    function Assigned: Boolean; override;
    procedure OnTrigger(Sender: TObject); override;

  public
    RowCount: Integer;
    Callback: TGetRowCount;
  end;

  TGetCellColorEvent = class (TSafeEvent)
  protected
    function Assigned: Boolean; override;
    procedure OnTrigger(Sender: TObject); override;

  public
    Col: Integer;
    Row: Integer;
    Column: TObject;
    Color: TColor;
    Callback: TGetCellColor;

    procedure Init(Col, Row: Integer; Column: TObject);
  end;

implementation

uses
  sysutils,
  dialogs;

{ TSafeEvent }

constructor TSafeEvent.Create;
begin
  FOnError := ShowDialog;
end;

procedure TSafeEvent.ShowDialog(const AMessage: string);
begin
  ShowMessage('TSafeEvent: Failure while triggering event. Error reason: ' + AMessage);
end;

procedure TSafeEvent.Trigger(Sender: TObject);
begin
  try

    if Assigned then
    begin
      OnTrigger(Sender);
    end;

  except

    on e: Exception do
    begin
      OnError(e.Message); 
    end;

  end;
end;

{ TDataEvent }

function TListDataEvent.Assigned: Boolean;
begin
  Result := System.Assigned(Callback);
end;

procedure TListDataEvent.OnTrigger(Sender: TObject);
begin
  Callback(Sender, ID, Column, Row);
end;


{ TGetRowCountEvent }

function TGetRowCountEvent.Assigned: Boolean;
begin
  Result := System.Assigned(Callback);
end;

procedure TGetRowCountEvent.OnTrigger(Sender: TObject);
begin
  Callback(Sender, RowCount);
end;

{ TGetCellColorEvent }

function TGetCellColorEvent.Assigned: Boolean;
begin
  Result := System.Assigned(Callback);
end;

procedure TGetCellColorEvent.OnTrigger(Sender: TObject);
begin
  Callback(Sender, Col, Row, Column, Color);
end;

procedure TGetCellColorEvent.Init(Col, Row: Integer; Column: TObject);
begin
  Self.Col := Col;
  Self.Row := Row;
  Self.Column := Column;
end;

end.
