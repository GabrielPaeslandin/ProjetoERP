unit uMENU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus;

type

  { TMainMenuF }

  TMainMenuF = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro: TMenuItem;
    Categoria: TMenuItem;
    Cliente: TMenuItem;
    Orcamento: TMenuItem;
    RelOrcamento: TMenuItem;
    RelProdutos: TMenuItem;
    RelClientes: TMenuItem;
    Usuarios: TMenuItem;
    Produtos: TMenuItem;
    Sair: TMenuItem;
    Sobre: TMenuItem;
    Relatorios: TMenuItem;
    Vendas: TMenuItem;
    procedure SairClick(Sender: TObject);
  private

  public

  end;

var
  MainMenuF: TMainMenuF;

implementation

{$R *.lfm}

{ TMainMenuF }

procedure TMainMenuF.SairClick(Sender: TObject);
begin
  MainMenuF.Close;

end;

end.

