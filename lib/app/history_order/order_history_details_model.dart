import 'package:intl/intl.dart';

import '../../data/remote/api_service.dart';

class OrderHistoryDetailsModel {


  final int id;
  final String user;
  final String zone;
  final String deliveryAddress;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final String formatedDateTime;
  final List<OrderProduct> orderProducts;

  OrderHistoryDetailsModel({
    required this.id,
    required this.user,
    required this.zone,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.formatedDateTime,
    required this.orderProducts,
  });

  factory OrderHistoryDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDetailsModel(
      id: json['id'],
      user: json['user'],
      zone: json['zone'],
      deliveryAddress: json['delivery_address'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      formatedDateTime: doFormatDateTime(json['created_at']),
      orderProducts: (json['order_products'] as List)
          .map((product) => OrderProduct.fromJson(product))
          .toList(),
    );
  }
}

class OrderProduct {
  final int id;
  final String productName;
  final String productImage;
  final int quantity;
  final String unit;
  final double totalAmount;

  OrderProduct({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.unit,
    required this.totalAmount,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      productName: json['product_name'],
      productImage: json['product_image'] != null
          ? ApiService.imageBaseUrl + json['product_image']
          : '',
      quantity: json['quantity'],
      unit: json['unit'],
      totalAmount: (json['total_amount'] as num).toDouble(),
    );
  }
}


String doFormatDateTime(String utcDateTime) {
  // Parse the UTC date-time string
  DateTime utcTime = DateTime.parse(utcDateTime);

  // Add 6 hours to convert UTC to Bangladesh time (BST)
  DateTime bangladeshTime = utcTime.add(Duration(hours: 6));

  // Format the Bangladesh time as dd/MM/yyyy, hh:mm:ss a
  String formattedTime = DateFormat('dd/MM/yyyy, hh:mm:ss a').format(bangladeshTime);

  return formattedTime;
}







