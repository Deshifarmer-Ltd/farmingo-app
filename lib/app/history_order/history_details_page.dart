import 'package:farmingo/app/history_order/order_history_details_model.dart';
import 'package:farmingo/common/style.dart';
import 'package:farmingo/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends GetView<CommonController> {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        if (controller.orderDetailsHistory.value != null) {
          OrderHistoryDetailsModel model =
          controller.orderDetailsHistory.value!;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Order Details"),
                Row(
                  children: [

                    Text('Order Id:', style: MStyle.value1Style,),
                    Gap(12),
                    Text(model.id.toString(), style: MStyle.fieldValue2Style,),

                  ],
                ),
                Row(
                  children: [

                    Text('User:', style: MStyle.value1Style,),
                    Gap(12),

                    Text(model.user, style: MStyle.fieldValue2Style,),

                  ],
                ),
                Row(
                  children: [

                    Text('Zone:', style: MStyle.value1Style,),
                    Gap(12),

                    Text(model.zone, style: MStyle.fieldValue2Style,),

                  ],
                ),
                Row(
                  children: [

                    Text('Delivery Address:', style: MStyle.value1Style,),
                    Gap(12),

                    Text(model.deliveryAddress, style: MStyle.fieldValue2Style,),

                  ],
                ),
                Row(
                  children: [

                    Text('Status:', style: MStyle.value1Style,),
                    Gap(12),

                    Text(model.status, style: MStyle.fieldValue2Style,),

                  ],
                ),
                Row(
                  children: [

                    Text('Total amount:', style: MStyle.value1Style,),
                    Gap(12),

                    Text(
                      "৳ ${model.totalAmount.toInt().toString()}",
                      style: MStyle.fieldValue2Style,),

                  ],
                ),
                Row(
                  children: [

                    Text('Created at:', style: MStyle.value1Style,),
                    Gap(12),

                    Text(model.formatedDateTime, style: MStyle.fieldValue2Style,),

                  ],
                ),

                buildProductList(context),

              ],
            ),
          );
        } else {
          return Text("no data");
        }
      })),
    );
  }

  Widget buildProductList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          OrderProduct p = controller.orderDetailsHistory.value!.orderProducts
              .elementAt(i);


          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              // height:
              // MediaQuery
              //     .of(context)
              //     .size
              //     .height * 1/8,
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
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(8.0),
                          // Optional: For rounded corners
                          child:
                          p.productImage != null
                              ? Image.network(
                            p.productImage!,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            'assets/images/no_image.png',
                            height: 150 - 10,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text( p.productName,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style:  TextStyle(fontSize: 14.sp)),

                              Row(
                                children: [

                                  Text('Quantity:', style: MStyle.value1Style,),
                                  Gap(12),
                                  Text(p.quantity.toString(), style: MStyle.fieldValue2Style,),

                                ],
                              ),
                              Row(
                                children: [

                                  Text('Amount:', style: MStyle.value1Style,),
                                  Gap(12),

                                  Text(p.unit, style: MStyle.fieldValue2Style,),

                                ],
                              ),
                              Row(
                                children: [

                                  Text('price:', style: MStyle.value1Style,),
                                  Gap(12),

                                  Text(
                                    "৳ ${p.totalAmount.toInt().toString()}", style: MStyle.fieldValue2Style,),

                                ],
                              ),

                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: controller.orderDetailsHistory.value!.orderProducts.length,
        shrinkWrap: true,),
    );
  }
}
