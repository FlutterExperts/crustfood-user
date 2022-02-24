import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String documentId;
  String orderNumber;
  double totalPrice;
  int totalQuantity;
  int shippingPrice;
  String phone;
  String userName;
  String Routes;
  String orderStatus;
  Timestamp dateTime;
  List listFood;

  OrderModel(
      {this.documentId,
      this.orderNumber,
      this.totalPrice,
      this.totalQuantity,
      this.shippingPrice,
      this.phone,
      this.userName,
      this.Routes,
      this.orderStatus,
      this.dateTime,
      this.listFood});
}
