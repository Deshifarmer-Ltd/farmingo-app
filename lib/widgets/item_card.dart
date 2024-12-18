import 'package:farmingo/app/home/cart_item_model.dart';
import 'package:farmingo/app/home/common_controller.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCard extends StatelessWidget {
  final ProductModel item;
  RxInt count = 0.obs;
  late CartItemModel cartItem;
  CommonController ctr = Get.find<CommonController>();

  ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
                  Image.network(
                    height: constrain.maxHeight * 0.4,
                    // height: MediaQuery.of(context).size.height*0.2,
                    item.image,
                    fit: BoxFit.cover,
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
                    return (count > 0)
                        ? Container(
                      height: constrain.maxHeight * 0.18,
                            width: 120,
                            decoration: const BoxDecoration(
                                color: Color(0xFF16A34A),
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
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

                                Text(count.value.toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),


                                GestureDetector(
                                  onTap: onPlusBtnPressed,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )



                              ],
                            ),
                          )
                        : SizedBox(
                            height: constrain.maxHeight * 0.18,
                            child: TextButton(
                              // style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))),
                              onPressed: onAddBtnPressed,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  "ADD",
                                ),
                              ),
                            ));
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
                    count.value++;
                    cartItem.count = count;
                  }

  void onAddBtnPressed() {
              count.value = 1;

              cartItem =
                  CartItemModel(product: item, count: count);

              ctr.cartItemList.add(cartItem);
            }

  void onMinusBtnPressed() {
    count.value--;
    cartItem.count = count;

    // removing while count is 0

    cartItem.count.listen((value) {
      if (value == 0) {
        ctr.cartItemList.remove(cartItem);
      }
    });
  }
}
