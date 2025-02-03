import 'package:farmingo/common_controller.dart';
import 'package:farmingo/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/item_card.dart';
import '../../widgets/simmer_loading.dart';

class AllProductPage extends GetView<CommonController> {

  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomAppbar(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              controller.selectedAllProductCategoryTitle,
              style:  TextStyle(
                  color: Colors.green,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child:  Obx((){
           return  controller.selectedAllProductList.isNotEmpty?

            GridView.builder(
              controller: controller.scrollController,
                itemCount: controller.selectedAllProductList.length,
                shrinkWrap: true,
                gridDelegate:
                //mainAxisExtent means height of the title
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 230),
                itemBuilder: (ctx, i) {
                  var item = controller.selectedAllProductList.elementAt(i);

                  return ItemCard(
                    index: i,
                    item: item,
                  );
                },
              ):const SimmerLoading();

            })
          ),
        ],
      )),
    );
  }
}
