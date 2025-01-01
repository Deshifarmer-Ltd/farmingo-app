class OrderHistoryModel {
  final int id;
  final String user;
  final String zone;
  final String deliveryAddress;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  OrderHistoryModel({
    required this.id,
    required this.user,
    required this.zone,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  // Factory method to create an instance from JSON
  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      user: json['user'],
      zone: json['zone'],
      deliveryAddress: json['delivery_address'],
      totalAmount: json['total_amount'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }


}
