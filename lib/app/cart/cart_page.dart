import 'package:farmingo/app/home/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends GetView<CommonController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return controller.cartItemList.isNotEmpty
              ? ListView.builder(itemBuilder: (ctx, i) {
                  var item = controller.cartItemList.elementAt(i);

                  return ListTile(
                    leading: Text(item.product.name),
                    trailing: Text(item.count.value.toString()),
                  );
                },itemCount: controller.cartItemList.length,)
              : Text('Cart Is empty');
        }),
      ),
    );
  }
}
