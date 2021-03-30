class PastTransaction{

  int id;
  String transaction_number;
  String transaction_type;
  String total_price;
  String tax;
  String grand_total;
  String discount;
  String voucher_code;

  PastTransaction(
      this.id,
      this.transaction_number,
      this.transaction_type,
      this.total_price,
      this.tax,
      this.grand_total,
      this.discount,
      this.voucher_code);

  PastTransaction.fromJson(Map<String, dynamic> json):
      id = json["id"],
      transaction_number = json["transaction_number"],
      transaction_type = json["transaction_type"],
      total_price = json["total_price"],
      tax = json["tax"],
      grand_total = json["grand_total"],
      discount = json["discount"],
      voucher_code = json["voucher_code"];

  Map<String, dynamic> toJson() =>
      {
        "id" : id,
        "transaction_number" : transaction_number,
        "transaction_type" : transaction_type,
        "total_price" : total_price,
        "tax" : tax,
        "grand_total" : grand_total,
        "discount" : discount,
        "voucher_code" : voucher_code
      };

}