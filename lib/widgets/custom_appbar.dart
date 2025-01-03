import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:farmingo/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_routes.dart';

class CustomAppbar extends GetView<CommonController> {
  CustomAppbar({super.key});

  //todo: make hint / font size dynamic for all screen
  AuthController authCtr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          authCtr.user.value == null
              ? IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.loginPath);
                  },
                  icon: const Icon(
                    Icons.person_2_outlined,
                  ))
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
                  }),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * (1 / 15),
              child:  Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: SearchBar(
                  onTap: (){

                    Get.toNamed(AppRoutes.searchPath);

                  },
                  onChanged: (query){

                    controller.fetchSearchProducts(query);


                  },
                  hintText: 'Search your fresh vegetables',
                  trailing: [Icon(Icons.search_rounded)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              label: Obx(() {
                return Text(controller.cartItemList.length.toString());
              }),
              child: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.cartPath);
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
