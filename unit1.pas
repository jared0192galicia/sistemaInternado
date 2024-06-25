unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, mysql80conn, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, MainMenu;

type

  { TForm1 }

  TForm1 = class(TForm)
    Connection: TMySQL80Connection;
    DataSource1: TDataSource;
    ePassword: TEdit;
    eUser: TEdit;
    Image1: TImage;
    lblTitle: TLabel;
    Panel1: TPanel;
    Query: TSQLQuery;
    Transaction: TSQLTransaction;
    procedure bAccederClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormCreate(Sender: TObject);
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

  try
    Connection.Connected := True;
    Transaction.Active := True;
  except
    on E: Exception do
    begin
      ShowMessage('Error al conectar con la base de datos: ' + E.Message);
      Halt;  // Detener la aplicación si no puede conectarse a la base de datos
    end;
  end;
end;

procedure TForm1.Panel1Click(Sender: TObject);
var
  username, password: string;
begin
  username := eUser.Text;
  password := ePassword.Text;

  // Verificar que los campos no estén vacíos
  if (username = '') or (password = '') then
  begin
    ShowMessage('Por favor, ingrese su usuario y contraseña.');
    Exit;
  end;

  // Consultar la base de datos para verificar las credenciales
  //Query.DataSource=DataSource1;
  Query.DataBase := Connection;
  Query.SQL.Text := 'SELECT * FROM users WHERE user = :username AND pass = :password';
  Query.ParamByName('username').AsString := username;
  Query.ParamByName('password').AsString := password;
  Query.Open;

  // Verificar si se encontró un usuario con las credenciales ingresadas
  if not Query.EOF then
  begin
    if (Query.FieldByName('user').AsString = username) and (Query.FieldByName('pass').AsString = password) then
    begin
      Self.Hide; // Ocultar el formulario de login
      frmMainMenu.ShowModal();
    end
    else
    begin
      ShowMessage('Credenciales incorrectas. Inténtelo de nuevo.');
    end;
  end
  else
  begin
    ShowMessage('Credenciales incorrectas. Inténtelo de nuevo.');
  end;

  Query.Close;

end;


procedure TForm1.bAccederClick(Sender: TObject);
var
  username, password: string;
begin
  username := eUser.Text;
  password := ePassword.Text;

  // Verificar que los campos no estén vacíos
  if (username = '') or (password = '') then
  begin
    ShowMessage('Por favor, ingrese su usuario y contraseña.');
    Exit;
  end;

  // Consultar la base de datos para verificar las credenciales
  //Query.DataSource=DataSource1;
  Query.DataBase := Connection;
  Query.SQL.Text := 'SELECT * FROM users WHERE user = :username AND pass = :password';
  Query.ParamByName('username').AsString := username;
  Query.ParamByName('password').AsString := password;
  Query.Open;

  // Verificar si se encontró un usuario con las credenciales ingresadas
  if not Query.EOF then
  begin
    if (Query.FieldByName('user').AsString = username) and (Query.FieldByName('pass').AsString = password) then
    begin
      //Form2 := TForm2.Create(Self); // Crear la instancia del nuevo formulario
      //Form2.Show; // Mostrar el nuevo formulario
      Self.Hide; // Ocultar el formulario de login

      frmMainMenu.ShowModal();
    end
    else
    begin
      ShowMessage('Credenciales incorrectas. Inténtelo de nuevo.');
    end;
  end
  else
  begin
    ShowMessage('Credenciales incorrectas. Inténtelo de nuevo.');
  end;

  Query.Close;
end;

end.

