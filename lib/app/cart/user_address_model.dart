class AddressModel {
  final int id;
  final int userId;
  final String receiverName;
  final String receiverPhone;
  final String address;

  AddressModel({
    required this.id,
    required this.userId,
    required this.receiverName,
    required this.receiverPhone,
    required this.address,

  });

  // Factory constructor to create an instance from a JSON map
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      receiverName: json['receiver_name'],
      receiverPhone: json['receiver_phone'],
      address: json['address'],

    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'receiver_name': receiverName,
      'receiver_phone': receiverPhone,
      'address': address,

    };
  }
}
