
import 'package:farmingo/data/remote/api_service.dart';

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String status;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.status,
  });

  // Factory constructor to create an object from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image:
          json['image'] != null ? ApiService.imageBaseUrl + json['image'] : '',
      status: json['status'],
    );
  }

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'status': status,
    };
  }
}

class ProductModel           {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String image;
  final int weight;
  final String measurement;
  final String unit;
  final int price;
  final String status;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.image,
    required this.weight,
    required this.measurement,
    required this.unit,
    required this.price,
    required this.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      image:
      json['image'] != null ? ApiService.imageBaseUrl + json['image'] : '',
      weight: json['weight'],
      measurement: json['mesurement'],
      // Note: fixed spelling to 'measurement'
      unit: json['unit'],
      price: json['price'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': image,
      'weight': weight,
      'mesurement': measurement, // Note: kept spelling consistent with input
      'unit': unit,
      'price': price,
      'status': status,
    };
  }
}


class ItemModel extends CategoryModel {
  final List<ProductModel>? products;

  ItemModel({
    this.products,
    required super.id,
    required super.image,
    required super.name,
    required super.slug,
    required super.status,
  });


  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image:
      json['image'] != null ? ApiService.imageBaseUrl + json['image'] : '',
      status: json['status'],

      products:  json['products'] != null
          ? List.from(json['products'])
          .map((e) => ProductModel.fromJson(e))
          .toList()
          : null,

    );
  }
}
