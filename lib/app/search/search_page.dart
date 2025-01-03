import 'package:farmingo/common_controller.dart';
import 'package:farmingo/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/item_card.dart';
import '../../widgets/simmer_loading.dart';

class SearchPage extends GetView<CommonController> {

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomAppbar(),


          Expanded(
            child:  Obx((){

           return  controller.searchedProductList.isNotEmpty?

            GridView.builder(
                itemCount: controller.searchedProductList.length,
                shrinkWrap: true,
                gridDelegate:
                //mainAxisExtent means height of the title
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 230),
                itemBuilder: (ctx, i) {
                  var item = controller.searchedProductList.elementAt(i);

                  return ItemCard(
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
