unit UploadFiles;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, mysql80conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TfrmUploadFile }

  TfrmUploadFile = class(TForm)
    bSearch: TButton;
    bSelectSertificado: TButton;
    bActaNac: TButton;
    bSelectSertificado10: TButton;
    bSelectSertificado2: TButton;
    bSelectSertificado3: TButton;
    bSelectSertificado4: TButton;
    bSelectSertificado5: TButton;
    bSelectSertificado6: TButton;
    bSelectSertificado7: TButton;
    bSelectSertificado8: TButton;
    bSelectSertificado9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Conexion: TMySQL80Connection;
    DataSource: TDataSource;
    Image1: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    label14: TLabel;
    Label15: TLabel;
    print: TLabel;
    label67: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    label68: TLabel;
    label69: TLabel;
    Label7: TLabel;
    label78: TLabel;
    label79: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    bSave: TPanel;
    Query: TSQLQuery;
    Transacion: TSQLTransaction;
    txtSertificadoEstudio: TEdit;
    txtName: TEdit;
    Label1: TLabel;
    txtMat: TEdit;
    openDialog: TOpenDialog;
    Panel1: TPanel;
    txtNameTwo: TEdit;
    txtSecondName: TEdit;
    txtSecondNameTwo: TEdit;
    txtActaNac: TEdit;
    txtcursosCapacitacion: TEdit;
    txtIne: TEdit;
    txtCurp: TEdit;
    txtRFC: TEdit;
    txtCompDomicilio: TEdit;
    txtCartaCompromisoInt: TEdit;
    txtCertMedico: TEdit;
    txtCertificadoPsicologico: TEdit;
    txtCartaProtesta: TEdit;
    procedure bSaveClick(Sender: TObject);
    procedure bSaveDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure bSaveMouseEnter(Sender: TObject);
    procedure bSaveMouseLeave(Sender: TObject);
    procedure bSearchClick(Sender: TObject);
    procedure bSelectSertificado10Click(Sender: TObject);
    procedure bActaNacClick(Sender: TObject);
    procedure bSelectSertificado2Click(Sender: TObject);
    procedure bSelectSertificado3Click(Sender: TObject);
    procedure bSelectSertificado4Click(Sender: TObject);
    procedure bSelectSertificado5Click(Sender: TObject);
    procedure bSelectSertificado6Click(Sender: TObject);
    procedure bSelectSertificado7Click(Sender: TObject);
    procedure bSelectSertificado8Click(Sender: TObject);
    procedure bSelectSertificado9Click(Sender: TObject);
    procedure bSelectSertificadoClick(Sender: TObject);
    procedure conectarBD();
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure openFile(typeFile : string; var txtField : TEdit);
    procedure saveFile(path : string; field : string);
  private
    idStudent : integer;

  public


  end;

var
  frmUploadFile: TfrmUploadFile;

implementation

{$R *.lfm}

{ TfrmUploadFile }

procedure TfrmUploadFile.bSaveClick(Sender: TObject);  
var
  FileStream: TFileStream;
  SQLQuery : TSQLQuery;
begin
  //try
    // Crear el componente TSQLQuery
    SQLQuery := TSQLQuery.Create(nil);
  //  try
  //    // Configurar la conexión y la transacción
  //    SQLQuery.DataBase := Conexion; // Tu componente TMySQL80Connection
  //    SQLQuery.Transaction := Transacion; // Tu componente TSQLTransaction
  //
  //    // Verificar si existe un registro para el alumno
  //    SQLQuery.SQL.Text := 'SELECT COUNT(*) FROM documents WHERE idAlumno = :idAlumno';
  //    SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
  //    SQLQuery.Open;
  //
  //    if SQLQuery.Fields[0].AsInteger = 0 then
  //    begin
  //      // No existe un registro, insertar uno nuevo
  //      SQLQuery.Close;
  //      SQLQuery.SQL.Text := 'INSERT INTO documents (idAlumno, ' + field + ') VALUES (:idAlumno, :BlobData)';
  //      SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
  //      SQLQuery.Params.ParamByName('BlobData').LoadFromStream(FileStream, ftBlob);
  //      SQLQuery.ExecSQL;
  //    end
  //    else
  //    begin
  //      // Existe un registro, actualizar el BLOB existente
  //      SQLQuery.Close;
  //      SQLQuery.SQL.Text := 'UPDATE documents SET ?? = :BlobData WHERE idAlumno = :idAlumno';
  //      SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
  //      SQLQuery.Params.ParamByName('BlobData').LoadFromStream(FileStream, ftBlob);
  //      SQLQuery.ExecSQL;
  //    end;
  //
  //    // Confirmar la transacción
  //    Transacion.Commit;
  //  finally
  //    SQLQuery.Free;
  //  end;
  //finally
  //  FileStream.Free;
  //end;
end;

procedure TfrmUploadFile.bSaveDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TfrmUploadFile.bSaveMouseEnter(Sender: TObject);
begin
  bSave.Color:=clWhite;
  bSave.Font.Color:=clTeal;
  bSave.BevelColor:=clTeal;
end;

procedure TfrmUploadFile.bSaveMouseLeave(Sender: TObject);
begin
  bSave.Color:=clTeal;     
  bSave.Font.Color:=clWhite;
end;

procedure TfrmUploadFile.bSearchClick(Sender: TObject);
begin
  Query.SQL.Text:='SELECT * FROM student WHERE matricula = "' + txtMat.Text + '"';
  DataSource.DataSet:=Query;

  Query.Open;
  Query.First;

  txtName.Text:=Query.FieldByName('primerNombre').AsString;
  txtNameTwo.Text:=Query.FieldByName('segundoNombre').AsString;
  txtSecondName.Text:=Query.FieldByName('apellidoPat').AsString;
  txtSecondNameTwo.Text:=Query.FieldByName('apellidoMat').AsString;

  idStudent := StrToInt(Query.FieldByName('id').AsString);
end;

procedure TfrmUploadFile.bSelectSertificado10Click(Sender: TObject);
begin
  openFile('Cursos de Capacitación', txtcursosCapacitacion);
  saveFile(txtcursosCapacitacion.Text, 'cursosCapacitacion');
end;

procedure TfrmUploadFile.bActaNacClick(Sender: TObject);
begin
  openFile('Acta de Nacimiento', txtActaNac);
  saveFile(txtActaNac.Text, 'actaNacimiento');
end;

procedure TfrmUploadFile.bSelectSertificado2Click(Sender: TObject);
begin
  openFile('Credencial de Elector', txtIne);    
  saveFile(txtIne.Text, 'credencialElector');
end;

procedure TfrmUploadFile.bSelectSertificado3Click(Sender: TObject);
begin
  openFile('CUPR', txtCurp);   
  saveFile(txtCurp.Text, 'curp');
end;

procedure TfrmUploadFile.bSelectSertificado4Click(Sender: TObject);
begin
  openFile('RFC', txtRFC);  
  saveFile(txtRFC.Text, 'rfc');
end;

procedure TfrmUploadFile.bSelectSertificado5Click(Sender: TObject);
begin
  openFile('Comprobante de domicilio', txtCompDomicilio); 
  saveFile(txtCompDomicilio.Text, 'compDomicilio');
end;

procedure TfrmUploadFile.bSelectSertificado6Click(Sender: TObject);
begin
  openFile('Carta Compromiso de Internado', txtCartaCompromisoInt); 
  saveFile(txtCartaCompromisoInt.Text, 'cartaComproInternado');
end;

procedure TfrmUploadFile.bSelectSertificado7Click(Sender: TObject);
begin
  openFile('Certificado Medico', txtCertMedico);
  saveFile(txtCertMedico.Text, 'certificadoMedico');
end;

procedure TfrmUploadFile.bSelectSertificado8Click(Sender: TObject);
begin
  openFile('Certificado Psicologico de Salud Mental', txtCertificadoPsicologico);
  saveFile(txtCertificadoPsicologico.Text, 'certificadoPscologSaludMental');
end;

procedure TfrmUploadFile.bSelectSertificado9Click(Sender: TObject);
begin
  openFile('Carta Protesta', txtCartaProtesta);    
  saveFile(txtCartaProtesta.Text, 'cartaProtesta');
end;

procedure TfrmUploadFile.bSelectSertificadoClick(Sender: TObject);
begin
  openFile('Certificado de Estudios', txtSertificadoEstudio);
  saveFile(txtSertificadoEstudio.Text, 'tiraMaterias');
end;


procedure TfrmUploadFile.conectarBD();
begin  
  Conexion.HostName:='127.0.0.1';
  Conexion.Password := 'DMR003QP10';
  Conexion.Port := 3306;
  Conexion.DatabaseName := 'visual';
  Conexion.UserName := 'root';
  Conexion.Connected := True;
  Conexion.KeepConnection := True;

  Transacion.DataBase := Conexion;
  Transacion.Action:=caCommit;
  Transacion.Active:=True;

  Query.DataBase:=Conexion;
  Query.UsePrimaryKeyAsKey:=False;

end;

procedure TfrmUploadFile.FormHide(Sender: TObject);
begin
  Conexion.Connected:=False;
end;

procedure TfrmUploadFile.FormShow(Sender: TObject);
begin
  conectarBD();
end;

procedure TfrmUploadFile.openFile(typeFile: string; var txtField : TEdit);
begin
  openDialog.Title:=typeFile;
  if openDialog.Execute then
     txtField.Text:=openDialog.FileName;
  begin

  end;
end;

procedure TfrmUploadFile.saveFile(path: string; field : string);
var
  FileStream: TFileStream;
  //BlobStream: TStream;
  SQLQuery: TSQLQuery;
  begin
    if (path = 'Seleccionar archivo') then exit();
    // Crear un FileStream para leer el archivo
    FileStream := TFileStream.Create(path, fmOpenRead or fmShareDenyWrite);
    try
      // Crear el componente TSQLQuery
      SQLQuery := TSQLQuery.Create(nil);
      try
        // Configurar la conexión y la transacción
        SQLQuery.DataBase := Conexion; // Tu componente TMySQL80Connection
        SQLQuery.Transaction := Transacion; // Tu componente TSQLTransaction

        // Verificar si existe un registro para el alumno
        SQLQuery.SQL.Text := 'SELECT COUNT(*) FROM documents WHERE idAlumno = :idAlumno';
        SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
        SQLQuery.Open;

        if SQLQuery.Fields[0].AsInteger = 0 then
        begin
          // No existe un registro, insertar uno nuevo
          SQLQuery.Close;
          SQLQuery.SQL.Text := 'INSERT INTO documents (idAlumno, ' + field + ') VALUES (:idAlumno, :BlobData)';
          SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
          SQLQuery.Params.ParamByName('BlobData').LoadFromStream(FileStream, ftBlob);
          SQLQuery.ExecSQL;
        end
        else
        begin
          // Existe un registro, actualizar el BLOB existente
          SQLQuery.Close;
          SQLQuery.SQL.Text := 'UPDATE documents SET ' + field + ' = :BlobData WHERE idAlumno = :idAlumno';
          SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
          SQLQuery.Params.ParamByName('BlobData').LoadFromStream(FileStream, ftBlob);
          SQLQuery.ExecSQL;
        end;

        // Confirmar la transacción
        Transacion.Commit;
      finally
        SQLQuery.Free;
      end;
    finally
      FileStream.Free;
    end;
  end;

end.
















