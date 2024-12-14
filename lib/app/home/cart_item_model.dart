import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:get/get.dart';

//its represent single cartItem model
class CartItemModel{

  final ProductModel product;
  RxInt count=1.obs;

  CartItemModel({required this.product,required this.count});

  @override
  String toString() {
    // TODO: implement toString
    return 'name: ${product.name} count: ${count.value}';
  }


}