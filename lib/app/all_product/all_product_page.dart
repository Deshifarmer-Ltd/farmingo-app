import 'package:farmingo/app/home/common_controller.dart';
import 'package:farmingo/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/item_card.dart';

class AllProductPage extends GetView<CommonController> {

  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              controller.selectedAllProductCategoryTitle,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: controller.selectedAllProductList.length,
              shrinkWrap: true,
              gridDelegate:
                  //mainAxisExtent means height of the title
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 230),
              itemBuilder: (ctx, i) {
                var item = controller.selectedAllProductList.elementAt(i);

                return ItemCard(
                  item: item,
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
