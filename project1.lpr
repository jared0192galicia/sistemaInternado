program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, unit1, UploadFiles, MainMenu, 
RegistrarCreditos, RegistroAlm
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmUploadFile, frmUploadFile);
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmCreditos, frmCreditos);
  Application.CreateForm(TfrmRegAlm, frmRegAlm);
  // Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

