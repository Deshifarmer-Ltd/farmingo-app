import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:farmingo/common/style.dart';
import 'package:farmingo/common_controller.dart';
import 'package:farmingo/data/remote/model/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import '../app_routes.dart';

class CustomAppbar extends GetView<CommonController> {
  CustomAppbar({super.key});

  //todo: make hint / font size dynamic for all screen
  AuthController authCtr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 40,
              width: 80,
              child: Image.asset('assets/images/app_title.png')),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.searchPath);
              },
              icon: Icon(Icons.search_rounded)),

          Obx((){

            return  GestureDetector(
              onTap: () {
                if (controller.zoneModels.isNotEmpty) {
                  showDialog(
                    barrierDismissible: false,
                      context: context,
                      builder: (ctx) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(mainAxisSize: MainAxisSize.min,children: [
                              Text(
                                'select a zone',
                                style: MStyle.value1Style,
                              ),
                              ...List.generate(controller.zoneModels.length, (i) {

                                ZoneModel model = controller.zoneModels.elementAt(i);

                                return TextButton(child: Text(model.name),onPressed: (){

                                  controller.selectedZone.value= model;
                                  Navigator.pop(ctx);



                                }, );
                              })
                            ]),
                          ),
                        );
                      });
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
            return authCtr.user.value == null
                ? GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginPath);
                    },
                    child: Icon(
                      Icons.person_2_outlined,
                    ),
                  )
                : PopupMenuButton(
                    icon: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        authCtr.userName.value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    itemBuilder: (ctx) {
                      return [
                        PopupMenuItem(
                          child: const Text('Order'),
                          onTap: () {
                            controller.fetchUserOrderHistory();
                            Get.toNamed(AppRoutes.orderHistoryPath);
                          },
                        ),
                        PopupMenuItem(
                          child: const Text('Logout'),
                          onTap: () {
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
                        ),
                      ];
                    });
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
