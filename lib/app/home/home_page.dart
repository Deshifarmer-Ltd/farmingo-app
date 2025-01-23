import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmingo/common_controller.dart';
import 'package:farmingo/app_routes.dart';
import 'package:farmingo/widgets/category_card.dart';
import 'package:farmingo/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/category_list_section.dart';
import '../../widgets/simmer_loading.dart';

class HomePage extends GetView<CommonController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          onPopInvokedWithResult: (value, result) {
            showDialog(context: context, builder: _showExitDialog);
          },
          canPop: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbar(),
                CarouselSlider(
                  items: [
                    Image.asset(
                      'assets/images/banner/banner_1.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/banner/banner_2.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/banner/banner_3.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ],
                  options: CarouselOptions(
                    aspectRatio: 26 / 9,
                    viewportFraction: 0.92,
                    autoPlay: true,
                    // autoPlayCurve: Curves.linear,
                  ),
                ),
                AspectRatio(
                    aspectRatio: 10 / 3.5,
                    child: Obx(() {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          var item = controller.categories[i];

                          return CategoryCard(
                            category: item,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: controller.categories.length,
                      );
                    })),
                Obx(() {
                  return (controller.categoryProducts.isEmpty)
                      ? SimmerLoading()
                      : Column(
                          children: [
                            ...List.generate(controller.categoryProducts.length,
                                (i) {
                              var y = controller.categoryProducts.elementAt(i);

                              return CategoryListSection(
                                title: y.name,
                                items: y.products ?? [],
                                // see more btn tap event
                                onTap: () {
                                  controller.selectedAllProductCategoryTitle =
                                      y.name;
                                  controller
                                      .fetchSingleCategoryProductsById(y.id);
                                  Get.toNamed(AppRoutes.allProductListPath);
                                },
                              );
                            }),
                          ],
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showExitDialog(BuildContext ctx) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      content: Text('Are you sure you want to close Farmingo app?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text('Yes')),
      ],
    );
  }
}
