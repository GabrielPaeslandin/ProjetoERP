unit uDataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset, ZSqlUpdate;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    qryClienteclienteid: TLongintField;
    qryClientecpf_cnpj_cliente: TStringField;
    qryClientenome_cliente: TStringField;
    qryClientetipo_cliente: TStringField;
    qryOrcamentoclienteid: TLongintField;
    qryOrcamentodt_orcamento: TDateTimeField;
    qryOrcamentodt_validade_orcamento: TDateTimeField;
    qryOrcamentoItemorcamentoid: TLongintField;
    qryOrcamentoItemorcamentoitemid: TLongintField;
    qryOrcamentoItemprodutodesc: TStringField;
    qryOrcamentoItemprodutoid: TLongintField;
    qryOrcamentoItemqt_produto: TFloatField;
    qryOrcamentoItemvl_total: TFloatField;
    qryOrcamentoItemvl_unitario: TFloatField;
    qryOrcamentoorcamentoid: TLongintField;
    qryOrcamentovl_total_orcamento: TFloatField;
    qryProdutocategoriaprodutoid: TLongintField;
    qryProdutods_produto: TStringField;
    qryProdutodt_cadastro_produto: TDateTimeField;
    qryProdutoobs_produto: TStringField;
    qryProdutoprodutoid: TLongintField;
    qryProdutostatus_produto: TStringField;
    qryProdutovl_venda_produto: TFloatField;
    ZConnection1: TZConnection;
    qryCategoria: TZQuery;
    qryCategoriacategoriaprodutoid: TLongintField;
    qryCategoriads_categoria_produto: TStringField;
    UpdateCategoria: TZUpdateSQL;
    qryGenerica: TZQuery;
    qryProduto: TZQuery;
    UpdateProduto: TZUpdateSQL;
    qryCliente: TZQuery;
    UpdateCliente: TZUpdateSQL;
    qryOrcamento: TZQuery;
    UpdateOrcamento: TZUpdateSQL;
    qryOrcamentoItem: TZQuery;
    UpdateOrcamentoItem: TZUpdateSQL;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryCategoriaNewRecord(DataSet: TDataSet);
    procedure qryClienteNewRecord(DataSet: TDataSet);
    procedure qryOrcamentoAfterInsert(DataSet: TDataSet);
    procedure qryOrcamentoAfterOpen(DataSet: TDataSet);
    procedure qryOrcamentoItemAfterPost(DataSet: TDataSet);
    procedure qryProdutoNewRecord(DataSet: TDataSet);
  private

  public
  function getSequence(const pNomeSequence: String): String;
  procedure SomaItens;
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }


function TDataModule1.getSequence(const pNomeSequence: String): String;
begin
     Result := '';
 try
     qryGenerica.close;
     qryGenerica.SQL.Clear;
     qryGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
     qryGenerica.Open;
     Result := qryGenerica.FieldByName('CODIGO').AsString;
 finally
   qryGenerica.Close;
 end;
end;

procedure TDataModule1.SomaItens;
begin
   if not (DataModule1.qryOrcamento.State in [dsEdit, dsInsert]) then
     DataModule1.qryOrcamento.Edit;

  if not (DataModule1.qryOrcamentoItem.State in [dsEdit, dsInsert]) then
     DataModule1.qryOrcamentoItem.Edit;


  DataModule1.qryOrcamentoItem.First;
  DataModule1.qryOrcamentovl_total_orcamento.AsFloat := 0;
  while not DataModule1.qryOrcamentoItem.Eof do
  begin
    DataModule1.qryOrcamentovl_total_orcamento.AsFloat := DataModule1.qryOrcamentovl_total_orcamento.AsFloat + DataModule1.qryOrcamentoItemvl_total.AsFloat;
    DataModule1.qryOrcamentoItem.next;
end;
  end;


procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
    ZConnection1.HostName := 'localhost';
  ZConnection1.DataBase := 'postgres';
  ZConnection1.User     := 'postgres';
  ZConnection1.Password := '0';
  ZConnection1.Port     := 5432;
  ZConnection1.Protocol := 'postgresql';
  ZConnection1.Connected := True;
end;

procedure TDataModule1.qryCategoriaNewRecord(DataSet: TDataSet);
  begin
  qryCategoriacategoriaprodutoid.AsString:= getSequence('categoria_produto_categoriaprodutoid_seq');
end;

procedure TDataModule1.qryClienteNewRecord(DataSet: TDataSet);
begin
  qryClienteclienteid.AsString:=getSequence('cliente_clienteid');
end;

procedure TDataModule1.qryOrcamentoAfterInsert(DataSet: TDataSet);
begin
  //CREATE SEQUENCE orcamento_orcamentoid_seq
  qryOrcamentoorcamentoid.AsInteger   := StrToInt(getSequence('orcamento_orcamentoid_seq'));
  qryOrcamentodt_orcamento.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now));
  qryOrcamentodt_validade_orcamento.AsDateTime := StrToDate(formatdatetime('dd/mm/yyyy', now + 15));
end;

procedure TDataModule1.qryOrcamentoAfterOpen(DataSet: TDataSet);
begin
 if qryOrcamentoorcamentoid.AsString <> '' then
 begin
      qryOrcamentoItem.Close;
      qryOrcamentoItem.ParamByName('orcamentoid').AsString := qryOrcamentoorcamentoid.AsString;
      qryOrcamentoItem.Open;
 end;
end;

{
procedure TDataModule1.qryOrcamentoItemqt_produtoChange(Sender: TField);
var  xQtde, xVlrUnit, xVlrTotal : double;
begin
  xQtde     := qryOrcamentoItemqt_produto.AsFloat;
  xVlrUnit  := qryOrcamentoItemvl_unitario.AsFloat;

  if  xQtde > 0  then
  begin
    xVlrTotal := xQtde * xVlrUnit;
    qryOrcamentoItemvl_total.AsFloat := xVlrTotal;
  end;
end;

procedure TDataModule1.qryOrcamentoAfterPost(DataSet: TDataSet);
begin
  SomaItens;
end;
      }
procedure TDataModule1.qryOrcamentoItemAfterPost(DataSet: TDataSet);
begin

end;

procedure TDataModule1.qryProdutoNewRecord(DataSet: TDataSet);
begin
   qryProdutoprodutoid.AsString:= getSequence('produto_produtoid');
  qryProdutodt_cadastro_produto.AsDateTime := now;
  qryProdutostatus_produto.AsString := 'Ativo';
end;

end.

