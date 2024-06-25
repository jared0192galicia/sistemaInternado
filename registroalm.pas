unit RegistroAlm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, mysql80conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls;

type

  { TfrmRegAlm }

  TfrmRegAlm = class(TForm)
    bSelectSertificado6: TButton;
    Connection: TMySQL80Connection;
    DataSource1: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    eMatricula: TEdit;
    eNombre1: TEdit;
    eNombre2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mensaje: TLabel;
    OpenDialog1: TOpenDialog;
    bSave: TPanel;
    Query: TSQLQuery;
    Transaction: TSQLTransaction;
    procedure bGuardarClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmRegAlm: TfrmRegAlm;

implementation

{$R *.lfm}

{ TfrmRegAlm }

procedure TfrmRegAlm.FormCreate(Sender: TObject);
begin
  // Configurar la conexión a la base de datos
  Connection.HostName := 'localhost';
  Connection.Password := 'DMR003QP10';
  Connection.Port := 3306;
  Connection.DatabaseName := 'visual';
  Connection.UserName := 'root';
  Connection.Connected := True;

  // Configurar la transacción y la consulta
  Transaction.DataBase := Connection;
  Transaction.Action := caCommit;
  Transaction.Active := True;

  Query.DataBase := Connection;
  Query.Transaction := Transaction;
end;

procedure TfrmRegAlm.bGuardarClick(Sender: TObject);
begin
  if not eNombre1.Enabled then
  exit;

  // Verificar que todos los campos estén completos
  if (eMatricula.Text = '') or (eNombre1.Text = '') or (eNombre2.Text = '') or
     (Edit1.Text = '') or (Edit2.Text = '') then
  begin
    ShowMessage('Por favor, complete todos los campos.');
    Exit;
  end;

  // Insertar los datos en la tabla student
  Query.SQL.Text := 'INSERT INTO student (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat) ' +
                    'VALUES (:matricula, :primerNombre, :segundoNombre, :apellidoPat, :apellidoMat)';
  Query.ParamByName('matricula').AsInteger := StrToInt(eMatricula.Text);
  Query.ParamByName('primerNombre').AsString := eNombre1.Text;
  Query.ParamByName('segundoNombre').AsString := eNombre2.Text;
  Query.ParamByName('apellidoPat').AsString := Edit1.Text;
  Query.ParamByName('apellidoMat').AsString := Edit2.Text;

  try
    Query.ExecSQL;
    Transaction.Commit;  // Confirmar la transacción
    mensaje.Visible:=true;
    //ShowMessage('Datos insertados correctamente.');
    // Limpiar los campos después de la inserción si es necesario
    eMatricula.Clear;
    eNombre1.Clear;
    eNombre2.Clear;
    Edit1.Clear;
    Edit2.Clear;
  except
    on E: Exception do
      ShowMessage('Error al insertar datos: ' + E.Message);
  end;
end;

procedure TfrmRegAlm.bSaveClick(Sender: TObject);
begin
  if not eNombre1.Enabled then
  exit;

  // Verificar que todos los campos estén completos
  if (eMatricula.Text = '') or (eNombre1.Text = '') or (eNombre2.Text = '') or
     (Edit1.Text = '') or (Edit2.Text = '') then
  begin
    ShowMessage('Por favor, complete todos los campos.');
    Exit;
  end;

  // Insertar los datos en la tabla student
  Query.SQL.Text := 'INSERT INTO student (matricula, primerNombre, segundoNombre, apellidoPat, apellidoMat) ' +
                    'VALUES (:matricula, :primerNombre, :segundoNombre, :apellidoPat, :apellidoMat)';
  Query.ParamByName('matricula').AsInteger := StrToInt(eMatricula.Text);
  Query.ParamByName('primerNombre').AsString := eNombre1.Text;
  Query.ParamByName('segundoNombre').AsString := eNombre2.Text;
  Query.ParamByName('apellidoPat').AsString := Edit1.Text;
  Query.ParamByName('apellidoMat').AsString := Edit2.Text;

  try
    Query.ExecSQL;
    Transaction.Commit;  // Confirmar la transacción
    mensaje.Visible:=true;
    //ShowMessage('Datos insertados correctamente.');
    // Limpiar los campos después de la inserción si es necesario
    eMatricula.Clear;
    eNombre1.Clear;
    eNombre2.Clear;
    Edit1.Clear;
    Edit2.Clear;
  except
    on E: Exception do
      ShowMessage('Error al insertar datos: ' + E.Message);
  end;
end;

end.

