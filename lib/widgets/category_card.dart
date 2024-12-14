import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/home/common_controller.dart';
import '../app/routes/app_routes.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  CategoryCard({super.key, required this.category});

  CommonController ctr = Get.find<CommonController>();

  //TODO: add effects on button press

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                ctr.selectedAllProductCategoryTitle = category.name;
                ctr.fetchSingleCategoryProductsById(category.id);
                Get.toNamed(AppRoutes.allProductListPath);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  // Optional: For rounded corners
                  child: category.image != null
                      ? Image.network(
                          category.image!,

                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          // errorBuilder: (ctx, obj, st) {
                          //   return Image.asset('name');
                          // }, // Makes the image fill the container
                        )
                      : Image.asset(
                          'assets/images/no_image.png',
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        )),
            ),
            Text(
              category.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
