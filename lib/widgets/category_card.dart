import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common_controller.dart';
import '../app_routes.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  CategoryCard({super.key, required this.category});

  final CommonController ctr = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: InkWell(
                onTap: () {
                  ctr.selectedAllProductCategoryTitle = category.name;
                  ctr.fetchSingleCategoryProductsById(category.id);
                  Get.toNamed(AppRoutes.allProductListPath);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    // Optional: For rounded corners
                    child: category.image != null
                        ?
                    CachedNetworkImage(
                      // height: constrain.maxHeight * 0.4,
                      width: 70,
                      fit: BoxFit.cover,
                      imageUrl: category.image!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                          LinearProgressIndicator(
                            value: downloadProgress.progress,
                            color: Colors.green.shade100,
                          ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/no_image.png',
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Image.asset(
                            'assets/images/no_image.png',
                            width: 90,
                            fit: BoxFit.cover,
                          )),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                category.name,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
