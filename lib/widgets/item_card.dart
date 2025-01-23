import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmingo/app/home/cart_item_model.dart';
import 'package:farmingo/common_controller.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCard extends StatelessWidget {
  int index;
  final ProductModel item;
  Rxn<CartItemModel> cartItem =
      Rxn<CartItemModel>(); // to make it a cart item if added
 final CommonController ctr = Get.find<CommonController>();

  ItemCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    // to load counter for initial build or repeat build
    ctr.cartItemList.forEach((cartModel) {
      if (item.id == cartModel.product.id) {
        cartItem.value = cartModel;
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (ctx, constrain) {
          return Container(
            width: constrain.maxHeight * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CachedNetworkImage(
                    height: constrain.maxHeight * 0.4,
                    imageUrl: item.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            LinearProgressIndicator(
                      value: downloadProgress.progress,
                      color: Colors.green.shade100,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '৳ ${item.price.toString()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold, // Bold text
                            color: Colors.green, // Custom color
                          ),
                        ),
                        TextSpan(
                          text: ' /${item.unit}', // The second part
                          style: const TextStyle(
                            fontSize: 14, // Smaller font size
                            fontWeight: FontWeight.normal, // Regular weight
                            color: Colors.grey, // A different color
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    if ((cartItem.value != null &&
                            cartItem.value!.count.value < 1) ||
                        cartItem.value == null) {
                      return SizedBox(
                          height: constrain.maxHeight * 0.18,
                          child: ElevatedButton(
                            onPressed: onAddBtnPressed,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "ADD",
                              ),
                            ),
                          ));
                    } else {
                      return Container(
                        height: constrain.maxHeight * 0.18,
                        width: 120,
                        decoration: const BoxDecoration(
                            color: Color(0xFF16A34A),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: onMinusBtnPressed,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            Text(cartItem.value!.count.value.toString(),
                                style: const TextStyle(color: Colors.white)),
                            GestureDetector(
                              onTap: onPlusBtnPressed,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onPlusBtnPressed() {
    cartItem.value!.count.value++;
  }

  void onAddBtnPressed() {
    cartItem.value = CartItemModel(product: item, count: 1.obs);

    ctr.cartItemList.add(cartItem.value!);
  }

  void onMinusBtnPressed() {
    if (cartItem.value!.count.value >= 1) {
      cartItem.value!.count.value--;

      if (cartItem.value!.count.value < 1) {
        ctr.cartItemList.remove(cartItem.value);
        cartItem.value = null;
      }
    }

    print('count........${ctr.cartItemList.length}');
  }
}
