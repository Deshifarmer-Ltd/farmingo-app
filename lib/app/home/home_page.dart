import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmingo/app/home/common_controller.dart';
import 'package:farmingo/app/routes/app_routes.dart';
import 'package:farmingo/widgets/category_card.dart';
import 'package:farmingo/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/category_list_section.dart';

class HomePage extends GetView<CommonController> {
  const HomePage({super.key});

  //todo: check network connectivity


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppbar(),
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
                    ? const Text('ff')
                    : Column(
                  children: [
                    ...List.generate(controller.categoryProducts.length, (i) {
                      var y = controller.categoryProducts.elementAt(i);

                      return CategoryListSection(
                        title: y.name,
                        items: y.products ?? [],
                        onTap: ()
                        {
                          controller.selectedAllProductCategoryTitle= y.name;
                          controller.selectedAllProductList=y.products??[];

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
    );
  }
}
