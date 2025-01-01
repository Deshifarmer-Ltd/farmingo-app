import 'package:farmingo/app/history_order/order_history_model.dart';
import 'package:farmingo/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../common/style.dart';

class OrderHistoryPage extends GetView<CommonController> {
  const OrderHistoryPage({super.key});
  //todo: add shimmer effect

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Obx(() {
      return controller.orderHistoryList.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                  itemCount: controller.orderHistoryList.length,
                  itemBuilder: (ctx, i) {
                    OrderHistoryModel item =
                        controller.orderHistoryList.elementAt(i);
                    return InkWell(
                      onTap: () {
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 10,left: 8,right: 8),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*1/7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(2))),
                              child: Row(
                                children: [
                                  //date and percentage
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [

                                          Text("Price", style: MStyle.headerStyle),
                                          Text(
                                            '৳ ${item.totalAmount}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: Colors.green),
                                          ),
                                        ],),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [


                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,children: [

                                              Text('Zone',
                                                  style: MStyle.headerStyle),
                                              Text(
                                                item.zone,
                                                style: MStyle.value1Style,
                                              ),
                                            ],),


                                            Column( crossAxisAlignment: CrossAxisAlignment.start,children: [

                                              Text('Order Id',
                                                  style: MStyle.headerStyle),
                                              Text(
                                                item.id.toString(),
                                                style: MStyle.value1Style,
                                              ),
                                            ],),
                                          ],),


                                        const Gap(8),
                                          Text(
                                            'Delivery Address',
                                            style: MStyle.headerStyle,
                                          ),
                                          Text(
                                            item.deliveryAddress  ,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: MStyle.value1Style,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: -10,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color:  Colors.green),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 3),
                                  child: Text(item.status,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }


                  ),
            )
          : const Text("Order history is empty");
    })));
  }
}
