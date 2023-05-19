unit uOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  StdCtrls, DBCtrls, Buttons, uProjetoFinal, DB, uDataModule,uPesquisaCliente;

type

  { TOrcamentoF }

  TOrcamentoF = class(TFormularioPadrao)
    BitBtnAdicionarItem: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBNomeCliente: TDBEdit;
    DbIDOrcamento: TDBEdit;
    dsOrcamentoItem: TDataSource;
    DBGrid2: TDBGrid;
    dsOrcamento: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel3: TPanel;
    Panel6: TPanel;
    SpeedButton1: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtnAdicionarItemClick(Sender: TObject);
    procedure BitBtnGravarPadrao1Click(Sender: TObject);
    procedure BitBtnSairPadrao1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private

  public

  end;

var
  OrcamentoF: TOrcamentoF;

implementation

{$R *.lfm}

{ TOrcamentoF }

procedure TOrcamentoF.BitBtn1Click(Sender: TObject);
var
AuxWhere : String;
begin
//Esta procedure irá executar a pesquisa da Categoria

if Edit1.Text = '' then
  AuxWhere := '1 = 1'
else
  AuxWhere := 'cast(orcamentoid as varchar(10)) = '+QuotedStr(Edit1.Text);

DataModule1.qryOrcamento.Close;
DataModule1.qryOrcamento.SQL.Text :=
            'SELECT '+
            'orcamentoid, '+
            'clienteid, '+
            'dt_orcamento, '+
            'dt_validade_orcamento, '+
            'vl_total_orcamento '+
            'FROM ORCAMENTO '+
            'WHERE '+ AuxWhere +' '+
            'ORDER BY orcamentoid';
DataModule1.qryOrcamento.Open;

end;

procedure TOrcamentoF.BitBtnAdicionarItemClick(Sender: TObject);
var
  proximoCodigo: integer;
begin
  dsOrcamentoItem.DataSet.Insert;

  // Busca o último código do item de orçamento
  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Add('SELECT MAX(orcamentoitemid) + 1 AS PROXCODIGO ' +
                                  'FROM orcamento_item ' +
                                  'WHERE ORCAMENTOID = ' + IntToStr(DataModule1.qryOrcamento.FieldByName('orcamentoid').AsInteger));
  DataModule1.qryGenerica.Open;

  if DataModule1.qryGenerica.FieldByName('PROXCODIGO').IsNull then
    proximoCodigo := 1
  else
    proximoCodigo := DataModule1.qryGenerica.FieldByName('PROXCODIGO').AsInteger;

  // Define o código do item de orçamento
  DataModule1.qryOrcamentoItem.FieldByName('orcamentoitemid').AsInteger := proximoCodigo;

  // Define o ID do orçamento atual
  DataModule1.qryOrcamentoItem.FieldByName('orcamentoid').AsInteger := DataModule1.qryOrcamento.FieldByName('orcamentoid').AsInteger;

  // Abre a tela para buscar o produto
  cadItemOrcF := TcadItemOrcF.Create(Self);     //Criar nova tela
  cadItemOrcF.ShowModal;
end;

procedure TOrcamentoF.BitBtnGravarPadrao1Click(Sender: TObject);
begin
     PageControlPadrao.TabIndex := 1;
  DataModule1.qryOrcamento.Insert;
  end;

procedure TOrcamentoF.BitBtnSairPadrao1Click(Sender: TObject);
begin
  inherited;
  Close;
end;


procedure TOrcamentoF.DBGrid1DblClick(Sender: TObject);
begin
 PageControlPadrao.Tabindex :=1;
 DataModule1.qryOrcamento.Edit;;
end;

procedure TOrcamentoF.Label2Click(Sender: TObject);
begin

end;

procedure TOrcamentoF.SpeedButton1Click(Sender: TObject);
begin
  PesquisaClienteF:= TPesquisaClienteF.create(Self);
   PesquisaClienteF.ShowModal;
end;


end.

