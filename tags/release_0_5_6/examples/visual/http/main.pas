unit main; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, lNet, lHTTP,
  lNetComponents, ExtCtrls, StdCtrls, Buttons, Menus;
  
type

  { TMainForm }

  TMainForm = class(TForm)
    ButtonSendRequest: TButton;
    EditPort: TEdit;
    EditURI: TEdit;
    EditHost: TEdit;
    HTTPClient: TLHTTPClientComponent;
    LabelPort: TLabel;
    LabelURI: TLabel;
    LabelHost: TLabel;
    MainMenu1: TMainMenu;
    MemoHTML: TMemo;
    MemoStatus: TMemo;
    MenuItemExit: TMenuItem;
    MenuItemAbout: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemFile: TMenuItem;
    MenuPanel: TPanel;
    procedure ButtonSendRequestClick(Sender: TObject);
    procedure EditHostKeyPress(Sender: TObject; var Key: char);
    procedure HTTPClientDisconnect(aSocket: TLSocket);
    procedure HTTPClientDoneInput(ASocket: TLHTTPClientSocket);
    procedure HTTPClientError(const msg: string; aSocket: TLSocket);
    function HTTPClientInput(ASocket: TLHTTPClientSocket; ABuffer: pchar;
      ASize: dword): dword;
    procedure HTTPClientProcessHeaders(ASocket: TLHTTPClientSocket);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
  private
    HTTPBuffer: string;
    procedure AppendToMemo(aMemo: TMemo; const aText: string);
    { private declarations }
  public
    { public declarations }
  end; 

var
  MainForm: TMainForm;

implementation

{ TMainForm }

procedure TMainForm.HTTPClientError(const msg: string; aSocket: TLSocket);
begin
  MessageDlg(msg, mtError, [mbOK], 0);
end;

procedure TMainForm.HTTPClientDisconnect(aSocket: TLSocket);
begin
  AppendToMemo(MemoStatus, 'Disconnected.');
end;

procedure TMainForm.ButtonSendRequestClick(Sender: TObject);
begin
  HTTPBuffer := '';
  HTTPClient.Host := EditHost.Text;
  HTTPClient.Port := Word(StrToInt(EditPort.Text));
  HTTPClient.URI := EditURI.Text;
  HTTPClient.SendRequest;
end;

procedure TMainForm.EditHostKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    ButtonSendRequestClick(Sender);
end;

procedure TMainForm.HTTPClientDoneInput(ASocket: TLHTTPClientSocket);
begin
  aSocket.Disconnect;
  AppendToMemo(MemoStatus, 'Finished.');
end;

function TMainForm.HTTPClientInput(ASocket: TLHTTPClientSocket; ABuffer: pchar;
  ASize: dword): dword;
var
  oldLength: dword;
begin
  oldLength := Length(HTTPBuffer);
  setlength(HTTPBuffer,oldLength + ASize);
  move(ABuffer^,HTTPBuffer[oldLength + 1], ASize);
  MemoHTML.Text := HTTPBuffer;
  MemoHTML.SelStart := Length(HTTPBuffer);
  AppendToMemo(MemoStatus, IntToStr(ASize) + '...');
  Result := aSize; // tell the http buffer we read it all
end;

procedure TMainForm.HTTPClientProcessHeaders(ASocket: TLHTTPClientSocket);
begin
  AppendToMemo(MemoStatus, 'Response: ' + IntToStr(HTTPStatusCodes[ASocket.ResponseStatus]) +
                    ' ' + ASocket.ResponseReason + ', data...');
end;

procedure TMainForm.MenuItemAboutClick(Sender: TObject);
begin
  MessageDlg('Copyright (c) 2006-2007 by Ales Katona and Micha Nelissen. All rights deserved :)',
             mtInformation, [mbOK], 0);
end;

procedure TMainForm.MenuItemExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.AppendToMemo(aMemo: TMemo; const aText: string);
begin
  aMemo.Append(aText);
  aMemo.SelStart := Length(aMemo.Text);
end;

initialization
  {$I main.lrs}

end.

