unit MainMenu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  RTTICtrls, RegistrarCreditos, RegistroAlm, UploadFiles;

type

  { TfrmMainMenu }

  TfrmMainMenu = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    panelSettings: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    bReport: TPanel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Image2Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
  private

  public

  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

{$R *.lfm}

{ TfrmMainMenu }

procedure TfrmMainMenu.Panel5Click(Sender: TObject);
begin
  frmRegAlm.showModal();
end;

procedure TfrmMainMenu.Panel2Click(Sender: TObject);
begin
  frmUploadFile.ShowModal;
end;

procedure TfrmMainMenu.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  Application.Terminate;
end;

procedure TfrmMainMenu.Image2Click(Sender: TObject);
begin
  ShowMessage('Settings');
end;

procedure TfrmMainMenu.Panel4Click(Sender: TObject);
begin
  frmCreditos.ShowModal;
end;

end.

