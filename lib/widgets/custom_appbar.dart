import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:farmingo/common/style.dart';
import 'package:farmingo/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import '../app_routes.dart';

class CustomAppbar extends GetView<CommonController> {
  CustomAppbar({super.key});

 final AuthController authCtr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (Get.currentRoute != AppRoutes.homePath) {
                Get.until((route) => route.settings.name == AppRoutes.homePath);              }
            },
            child: SizedBox(
                height: 40,
                width: 80,
                child: Image.asset('assets/images/app_title.png')),
          ),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.searchPath);
              },
              icon: Icon(Icons.search_rounded)),
          Obx(() {
            return GestureDetector(
              onTap: () {
                if (controller.zoneModels.isNotEmpty) {
                  controller.buildZoneDialog();
                }
              },
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(
                      controller.selectedZone.value?.name ?? 'Select Zone',
                      style: MStyle.value1Style,
                    )
                  ],
                ),
              ),
            );
          }),
          Obx(() {
            return (authCtr.isUserLoggedIn.value == false)
                ? GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginPath);
                    },
                    child: Icon(
                      Icons.person_2_outlined,
                    ),
                  )
                : CustomPopup(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.fetchUserOrderHistory();
                              Navigator.pop(context);
                              Get.toNamed(AppRoutes.orderHistoryPath);
                            },
                            child: const Text('Order')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                btnOkText: 'LOGOUT',
                                btnOkColor: Colors.red,
                                btnCancelColor: Colors.green,
                                title: 'Are you sure you want to log out',
                                titleTextStyle: const TextStyle(fontSize: 16),
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  authCtr.clearUserCredFromPref();
                                },
                              ).show();
                            },
                            child: const Text('Logout')),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        authCtr.userName.value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
          }),
          Obx(() {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.cartPath);
              },
              child: Badge.count(
                count: controller.cartItemList.length,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.green,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
