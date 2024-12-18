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
              ? ListView.builder(
                  itemBuilder: (ctx, i) {
                    var item = controller.cartItemList.elementAt(i);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.green.shade200,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      // Optional: For rounded corners
                                      child: item.product.image != null
                                          ? Image.network(
                                              item.product.image!,

                                              fit: BoxFit.cover,
                                              // errorBuilder: (ctx, obj, st) {
                                              //   return Image.asset('name');
                                              // }, // Makes the image fill the container
                                            )
                                          : Image.asset(
                                              'assets/images/no_image.png',
                                              height: 150 - 10,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                              ),
                              Expanded(flex: 7, child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name,overflow: TextOverflow.ellipsis,style: TextStyle()),
                                  Text(' ৳ ${item.product.price.toString()} each',style: TextStyle(color: Colors.grey),),
                                  Text(' Total:${item.product.weight*item.count.value} ${item.product.measurement}',style: TextStyle(color: Colors.grey)),
                                  Text(' price: ৳ ${item.product.price*item.count.value}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.cartItemList.length,
                )
              : Text('Cart Is empty');
        }),
      ),
    );
  }
}
