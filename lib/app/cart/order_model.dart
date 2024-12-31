class OrderModel {
  final int zoneId;
  final List<Product> products;
  final int? deliveryAddressId;
  final int deliveryCharge;
  final DeliveryInfo? deliveryInfo;

  OrderModel({
    required this.zoneId,
    required this.products,
    required this.deliveryAddressId,
    required this.deliveryCharge,
    required this.deliveryInfo
  });


  // Method to convert an Order object to JSON
  Map<String, dynamic> toJson() {

    if(deliveryInfo!=null)
    {

      return {
        'zone_id': zoneId,
        'product': products.map((item) => item.toJson()).toList(),
        'delivery_info': deliveryInfo!.toJson(),
        'delivery_charge': deliveryCharge,


      };

  }else{
      return {
        'zone_id': zoneId,
        'product': products.map((item) => item.toJson()).toList(),
        'delivery_address_id': deliveryAddressId,
        'delivery_charge': deliveryCharge,

      };

    }


  }
}

class Product {
  final int productId;
  final int quantity;

  Product({
    required this.productId,
    required this.quantity,
  });



  // Method to convert a Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }
}

class DeliveryInfo {
  final String name;
  final String address;
  final String phone;

  DeliveryInfo({
    required this.name,
    required this.address,
    required this.phone,
  });



  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
    };
  }
}

