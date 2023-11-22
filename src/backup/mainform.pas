unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LazSerial;

type

  { TMainFormPos }

  TMainFormPos = class(TForm)
    AddItemBtn: TButton;
    CheckoutBtn: TButton;
    edtPayment: TEdit;
    Label1: TLabel;
    lblChange: TLabel;
    PrintTax: TButton;
    lblTotal: TLabel;
    ListBox1: TListBox;
    procedure AddItemBtnClick(Sender: TObject);
    procedure CheckoutBtnClick(Sender: TObject);
    procedure PrintTaxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
       TotalAmount: Double;
  public

  end;

var
  MainFormPos: TMainFormPos;

implementation

{$R *.lfm}

{ TMainFormPos }
procedure TMainFormPos.FormCreate(Sender: TObject);
begin
   TotalAmount := 0.0;
end;
procedure TMainFormPos.AddItemBtnClick(Sender: TObject);
var
  ItemName: string;
  ItemPrice: Double;
begin
   // Meminta pengguna untuk detail barang
  ItemName := InputBox('Add Item', 'Enter item name:', '');
  if ItemName <> '' then
  begin
    // Untuk sederhananya, kita asumsikan setiap item memiliki harga tetap
    ItemPrice := StrToFloat(InputBox('Add Item', 'Enter item price:', '0.0'));

    // Menampilkan item di ListBox
    ListBox1.Items.Add(ItemName + ' - Rp.' + FloatToStr(ItemPrice) + ',00');

     // Memperbarui jumlah total
    TotalAmount := TotalAmount + ItemPrice;
    lblTotal.Caption := 'Total: Rp.' + FloatToStr(TotalAmount) + ',00';
  end;
end;

procedure TMainFormPos.CheckoutBtnClick(Sender: TObject);
var
  Payment: Double;
  Change: Double;
begin
  // Meminta pengguna untuk pembayaran
  Payment := StrToFloatDef(edtPayment.Text, 0.0);

  // Memeriksa apakah pembayaran mencukupi
  if Payment >= TotalAmount then
  begin
    // Menghitung kembalian
    Change := Payment - TotalAmount;
    lblChange.Caption := 'Kembalian : Rp.' + FloatToStr(Change) + ',00';

    // Menampilkan pesan
    ShowMessage('Checkout selesai.' + sLineBreak +
      'Total: Rp.' + FloatToStr(TotalAmount)+',00' + sLineBreak +
      'Bayar: Rp.' + FloatToStr(Payment) +',00' + sLineBreak +
      'Kembalian: Rp.' + FloatToStr(Change) + ',00');
  end
  else
    ShowMessage('Pembayaran tidak mencukupi. Mohon masukkan jumlah yang valid.');
end;

procedure TMainFormPos.PrintTaxClick(Sender: TObject);
begin
  // Untuk sederhananya, menampilkan struk di dalam kotak pesan
  ShowMessage('Struk:' + sLineBreak + ListBox1.Items.Text + sLineBreak +
    'Total: Rp.' + FloatToStr(TotalAmount) + ',00' + sLineBreak + FloatToStr(Change));
end;




end.

