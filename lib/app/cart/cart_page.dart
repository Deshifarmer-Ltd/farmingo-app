import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:farmingo/app/cart/user_address_model.dart';
import 'package:farmingo/common_controller.dart';
import 'package:farmingo/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartPage extends GetView<CommonController> {
  CartPage({super.key});

  RxInt totalPriceWithDeliveryCharge = 0.obs;
  AuthController authController = Get.find<AuthController>();

  //todo: after order placed remove cart item.

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
                        ElevatedButton(
                          onPressed: () {
                            openConfirmOrderPopUP(context);
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

    for (var model in controller.cartItemList) {
      totalPrice += model.count.value * model.product.price;
    }

    totalPriceWithDeliveryCharge.value = totalPrice + deliveryCharge;
  }

  void openConfirmOrderPopUP(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => SingleChildScrollView(
              child: AlertDialog(
                backgroundColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                insetPadding: const EdgeInsets.all(10),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      color: Colors.green.shade200,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Delivery Information',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    Obx(() {
                      return authController.addressList.isNotEmpty
                          ? Column(
                              children: [
                                CupertinoSlidingSegmentedControl(
                                  children: const {
                                    0: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text('Saved Address'),
                                    ),
                                    1: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text('Different Address'),
                                    ),
                                  },
                                  onValueChanged: (newButtonNumber) {
                                    if (newButtonNumber != null) {
                                      authController.sliderButtonNumber.value =
                                          newButtonNumber;
                                    }
                                  },
                                  groupValue:
                                      authController.sliderButtonNumber.value,
                                ),
                                authController.sliderButtonNumber.value == 0
                                    ? savedAddressSection() // saved address book
                                    : differentAddressSection()
                              ],
                            )
                          : differentAddressSection();
                    }),
                    Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // if not logged in... show the login page
                            //  -> after login get to confirm order then validate then place order

                            // if logged in then slider buttons available
                            //  -> then  check whether address book or different address selected
                            //  -> then validate accordingly

                            if (authController.isUserLoggedIn.value == false) {
                              Get.toNamed(AppRoutes.loginPath);
                            } else {
                              (authController.sliderButtonNumber.value == 0)
                                  ? authController.validateAddressBook()
                                  : authController.validateDifferentAddress();
                            }
                          },
                          child: const Text(
                            'Confirm Order',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ]),
                ),
              ),
            ));
  }

  Widget differentAddressSection() {
    return Form(
      key: authController.diffAddressFormKey,
      child: Column(
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              maxLines: 1,
              controller: authController.diffName,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                label: Text("Name"),
                hintText: 'Your name here',
              ),
              validator: (value) {
                if (value == null) {
                  return "Name is required";
                } else if (value == "") {
                  return "Name is required";
                } else {
                  return null;
                }
              },
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              maxLines: 1,
              maxLength: 11,
              controller: authController.diffPhone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                label: Text("Phone Number"),
                hintText: 'Your contact number here',
              ),
              validator: (value) {
                RegExp regExp = RegExp(r'^01[3-9]\d{8}$');
                if (value == null) {
                  return "Phone number is required";
                } else if (regExp.hasMatch(value)) {
                  return null;
                } else {
                  return 'Invalid phone number format';
                }
              },
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              maxLines: 3,
              controller: authController.diffAddress,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                label: Text("Delivery Address"),
                hintText:
                    'House/flat number, neighborhood name, area of contact',
              ),
              validator: (value) {
                if (value == null) {
                  return "Address is required";
                } else if (value == "") {
                  return "Address is required";
                } else {
                  return null;
                }
              },
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }

  Widget savedAddressSection() {
    return SizedBox(
        height: 200,
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            AddressModel model = authController.addressList.elementAt(i);

            return Obx(() {
              return RadioListTile(
                title: Text(model.receiverName),
                isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.address),
                    Text(model.receiverPhone),
                  ],
                ),
                value: model,
                onChanged: (newAddress) {
                  if (newAddress != null) {
                    authController.selectedAddress.value = newAddress;
                  }
                },
                groupValue: authController.selectedAddress.value,
              );
            });
          },
          shrinkWrap: true,
          itemCount: authController.addressList.length,
        ));
  }
}
