import 'package:farmingo/common_controller.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
            child: SearchBar(
              autoFocus: true,
              controller: controller.searchCtr,
              keyboardType: TextInputType.text,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              onChanged: (query) {
                controller.fetchSearchProducts(query);
              },
              hintText: 'Search your fresh vegetables',
              trailing: [

                IconButton(onPressed: (){
                  controller.searchCtr.clear();
                  controller.searchedProductList.clear();

                }, icon: Icon(Icons.highlight_remove_outlined))


                ],
            ),
          ),
          Expanded(child: Obx(() {
            return controller.searchedProductList.isNotEmpty
                ? GridView.builder(
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
                        index: i,
                      );
                    },
                  )
                : const SimmerLoading();
          })),
        ],
      )),
    );
  }
}
