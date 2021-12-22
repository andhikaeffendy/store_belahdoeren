import 'ItemsTransaction.dart';

class TransactionDetail{
  int id;
  String transaction_number;
  String transaction_date;
  String transaction_type;
  String total_price;
  String tax;
  String grand_total;
  String discount;
  String voucher_code;
  String branch_name;
  String my_address;
  int transaction_status;
  String userName;
  String userPhone;
  String transactionStatusName;
  int paymentMethodId;
  String paymentMethodName;
  List<ItemsTransaction> item ;

  TransactionDetail(
      this.id,
      this.transaction_number,
      this.transaction_type,
      this.total_price,
      this.tax,
      this.grand_total,
      this.discount,
      this.voucher_code,
      this.branch_name,
      this.my_address,
      this.transaction_status,
      this.transaction_date,
      this.userName,
      this.userPhone,
      this.transactionStatusName,
      this.paymentMethodId,
      this.paymentMethodName);

  TransactionDetail.fromJson(Map<String, dynamic> json):
      id = json["id"],
      transaction_number = json["transaction_number"],
      transaction_type = json["transaction_type"],
      total_price = json["total_price"],
      tax = json["tax"],
      grand_total = json["grand_total"],
      discount = json["discount"],
      voucher_code = json["voucher_code"],
      branch_name = json["branch_name"],
      my_address = json["my_address"],
      userName = json.containsKey("user_name") ? json["user_name"] : null,
      userPhone = json.containsKey("user_phone") ? json["user_phone"] : null,
      transaction_date = json.containsKey("transaction_date") ? json["transaction_date"] : null,
      paymentMethodId = json.containsKey("payment_method_id") ? json["payment_method_id"] : null,
      transactionStatusName = json.containsKey("transaction_status_name") ? json["transaction_status_name"] : null,
      paymentMethodName = json["payment_method_name"],
      transaction_status = json["transaction_status"];

  Map<String, dynamic> toJson() =>
      {
        "id" : id,
        "transaction_number" : transaction_number,
        "transaction_type" : transaction_type,
        "total_price" : total_price,
        "tax" : tax,
        "grand_total" : grand_total,
        "discount" : discount,
        "voucher_code" : voucher_code,
        "branch_name" : branch_name,
        "my_address" : my_address,
        "transaction_status" : transaction_status,
        "transaction_date" : transaction_date,
        "user_name" : userName,
        "user_phone" : userPhone,
        "transaction_status_name" : transactionStatusName,
        "payment_method_id" : paymentMethodId,
        "payment_method_name" : paymentMethodName,
      };

  bool transactionFinish() {
    return transactionStatusName.toLowerCase() == "selesai" ? true : false;
  }
}