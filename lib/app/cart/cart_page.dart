import 'package:farmingo/app/home/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartPage extends GetView<CommonController> {
  CartPage({super.key});

  RxInt totalPriceWithDeliveryCharge = 0.obs;

  //todo:toast msg is not working in benco

  @override
  Widget build(BuildContext context) {
    calculateTotal();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              return controller.cartItemList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          var item = controller.cartItemList.elementAt(i);

                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.green.shade200,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: InkWell(
                                            onTap: () {},
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                // Optional: For rounded corners
                                                child:
                                                    item.product.image != null
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
                                        Expanded(
                                            flex: 7,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item.product.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle()),
                                                Text(
                                                  ' ৳ ${item.product.price.toString()} each',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Obx(() {
                                                  return Text(
                                                      ' Total:${item.product.weight * item.count.value} ${item.product.measurement}',
                                                      style: const TextStyle(
                                                          color: Colors.grey));
                                                }),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Obx(() {
                                                      return Text(
                                                          ' price: ৳ ${item.product.price * item.count.value}',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .green));
                                                    }),

                                                    // counter button
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (item.count
                                                                    .value >
                                                                1) {
                                                              item.count
                                                                  .value--;

                                                              calculateTotal();
                                                            }
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              1.5))),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            6.0),
                                                                child: Icon(
                                                                  color: Colors
                                                                      .grey,
                                                                  Icons.remove,
                                                                  size: 16,
                                                                ),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Obx(() {
                                                            return Text(item
                                                                .count.value
                                                                .toString());
                                                          }),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            item.count.value++;
                                                            calculateTotal();
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              1.5))),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            6.0),
                                                                child: Icon(
                                                                  color: Colors
                                                                      .grey,
                                                                  Icons.add,
                                                                  size: 16,
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: IconButton(
                                      onPressed: () {
                                        item.count.value = 0;
                                        controller.cartItemList.removeAt(i);
                                        calculateTotal();
                                      },
                                      icon: Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.grey.shade200,
                                      )))
                            ],
                          );
                        },
                        itemCount: controller.cartItemList.length,
                      ),
                    )
                  : const Text('Cart Is empty');
            }),
            Obx(() {
              return controller.cartItemList.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                            'Total: ৳${totalPriceWithDeliveryCharge.value} (Delivery charge included)'),
                        TextButton(
                          // style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))),
                          onPressed: () {
                            Fluttertoast.showToast(msg: 'Processing');
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Proceed to Payment",
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox();
            })
          ],
        ),
      ),
    );
  }

  void calculateTotal() {
    int totalPrice = 0;
    int deliveryCharge = 50;

    // Use forEach instead of map
    for (var model in controller.cartItemList) {
      totalPrice += model.count.value * model.product.price;
    }

    totalPriceWithDeliveryCharge.value = totalPrice + deliveryCharge;
  }
}
