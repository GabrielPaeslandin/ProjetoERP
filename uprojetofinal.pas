unit uProjetoFinal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons;

type

  { TFormularioPadrao }

  TFormularioPadrao = class(TForm)
    BitBtnCancelarPadrao: TBitBtn;
    BitBtnSairPadrao: TBitBtn;
    BitBtnExcluirPadrao: TBitBtn;
    BitBtnGravarPadrao: TBitBtn;
    PanelPadrao: TPanel;
  private

  public

  end;

var
  FormularioPadrao: TFormularioPadrao;

implementation

{$R *.lfm}

end.

