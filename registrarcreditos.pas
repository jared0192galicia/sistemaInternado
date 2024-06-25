unit RegistrarCreditos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, mysql80conn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, DBGrids, ExtCtrls, CommCtrl, Windows;

type
  TLVHitTestInfo = record
    pt: TPoint;
    flags: UINT;
    iItem: Integer;
    iSubItem: Integer;
  end;

  { TfrmCreditos }

  TfrmCreditos = class(TForm)
    Conexion: TMySQL80Connection;
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    eSearch: TEdit;
    Image1: TImage;
    bSearch: TImage;
    Label1: TLabel;
    print: TLabel;
    Query: TSQLQuery;
    Transacion: TSQLTransaction;
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBGrid1EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bSearchClick(Sender: TObject);
    procedure fetchCredits();
    procedure formatToTable();
  private
    procedure conectarBd();

  public   
const
  LVM_SUBITEMHITTEST = LVM_FIRST + 57;

  end;

var
  frmCreditos: TfrmCreditos;
  matricula : string;

implementation

{$R *.lfm}

{ TfrmCreditos }

procedure TfrmCreditos.FormShow(Sender: TObject);
begin
  conectarBD(); 
  eSearch.SetFocus;
end;

procedure TfrmCreditos.bSearchClick(Sender: TObject);
begin
  try
    matricula := eSearch.Text;
    // Aquí puedes continuar con el procesamiento si la conversión es exitosa
  except
    on E: EConvertError do
    begin
      // Manejar el error de conversión
      ShowMessage('El valor ingresado no es válido.');
      Exit; // Salir del procedimiento si es necesario
    end;
  end;

  fetchCredits();
end;

procedure TfrmCreditos.fetchCredits();
begin
  Query.Clear;
  Query.DataBase := Conexion;
  Query.Transaction := Transacion;
  Query.SQL.Text := 'SELECT * FROM student_credits WHERE matricula LIKE :matricula';
  Query.ParamByName('matricula').AsString := matricula + '%';
  Query.Open;

  // Conectar el Query al DataSource
  DataSource.DataSet := Query;

  formatToTable();

end;

procedure TfrmCreditos.formatToTable();
begin
  DBGrid1.Columns[0].Width:=110;
  DBGrid1.Columns[0].ReadOnly:=True;

  DBGrid1.Columns[1].Width:=150;
  DBGrid1.Columns[1].ReadOnly:=True;
  DBGrid1.Columns[2].Width:=150;
  DBGrid1.Columns[2].ReadOnly:=True;
  DBGrid1.Columns[3].Width:=150;
  DBGrid1.Columns[3].ReadOnly:=True;
  DBGrid1.Columns[4].Width:=100;
  DBGrid1.Columns[5].Width:=100;
end;

procedure TfrmCreditos.FormHide(Sender: TObject);
begin
  Conexion.Connected:=False;
end;

procedure TfrmCreditos.DBGrid1ColExit(Sender: TObject);
begin

end;

procedure TfrmCreditos.DBGrid1EditingDone(Sender: TObject);
var
  SQLQuery: TSQLQuery;
  idStudent, newValue : integer;
  fieldName : string;
begin
  // Obtener el valores para la transaccion
  idStudent:= DBGrid1.DataSource.DataSet.Fields[0].AsInteger;
  newValue := DBGrid1.SelectedField.AsInteger;
                   
  // Asegúrate de que la conexión y la transacción están activas
  if not Conexion.Connected then
  begin
    ShowMessage('No hay conexión a la base de datos.');
    Exit;
  end;

  // Determinar el nombre del campo editado
  if DBGrid1.SelectedIndex = 4 then
    fieldName := 'creditos'
  else if DBGrid1.SelectedIndex = 5 then
    fieldName := 'hPractica'
  else
  begin
    ShowMessage('Campo no reconocido.');
    Exit;
  end;

  try
    // Crear el componente TSQLQuery
    SQLQuery := TSQLQuery.Create(nil);
    try
      // Configurar la conexión y la transacción
      SQLQuery.DataBase := Conexion;
      SQLQuery.Transaction := Transacion;

      // Verificar si existe un registro para el alumno
      SQLQuery.SQL.Text := 'SELECT COUNT(*) FROM credits WHERE idAlumno = :idAlumno';
      SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
      SQLQuery.Open;

      if SQLQuery.Fields[0].AsInteger = 0 then
      begin
        ShowMessage('Sin registro');
        // No existe un registro, insertar uno nuevo
        SQLQuery.Close;
         SQLQuery.SQL.Text := 'INSERT INTO credits (idAlumno, ' + fieldName + ') VALUES (:idAlumno, :' + fieldName + ')';
        SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
        SQLQuery.ParamByName(fieldName).AsInteger := newValue;
        SQLQuery.ExecSQL;
        //SQLQuery.Open;
      end
      else
      begin
        // Existe un registro, actualizar el registro existente 
        ShowMessage('Con registro');
        SQLQuery.Close;
        SQLQuery.SQL.Text := 'UPDATE credits SET ' + fieldName + ' = :' + fieldName + ' WHERE idAlumno = :idAlumno';
        SQLQuery.ParamByName('idAlumno').AsInteger := idStudent;
        SQLQuery.ParamByName(fieldName).AsInteger := newValue;
        SQLQuery.ExecSQL;    
        //SQLQuery.Open;
      end;

      // Confirmar la transacción
      Transacion.Commit;
    finally
      SQLQuery.Free;
    end;
  finally
    DataSource.DataSet.Open;
  end;
  formatToTable();
  //showData();

end;

procedure TfrmCreditos.FormCreate(Sender: TObject);
begin
end;

procedure TfrmCreditos.conectarBd();
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
end;

end.

