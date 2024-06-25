unit Conexion;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, mysql80conn, Forms, Controls, Graphics, Dialogs;

type

  { TForm2 }

  TForm2 = class(TForm)
    Conexion: TMySQL80Connection;
    Conexion1: TMySQL80Connection;
    DataSource: TDataSource;
    Query: TSQLQuery;
    Transacion: TSQLTransaction;
  private

  public


  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

end.

