import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:farmingo/app/home/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import '../app/routes/app_routes.dart';

class CustomAppbar extends GetView<CommonController> {
  CustomAppbar({super.key});

  //todo: make hint / font size dynamic for all screen
  AuthController ctr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          ctr.user.value == null
              ? IconButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>TestPage()));

                    Get.toNamed(AppRoutes.loginPath);
                  },
                  icon: const Icon(
                    Icons.person_2_outlined,
                  ))
              :   PopupMenuButton(icon: CircleAvatar(
            child: Text(ctr.userName.value),
          ),itemBuilder: (ctx) {


            return [
              const PopupMenuItem(child: Text('Profile')),
              const PopupMenuItem(child: Text('Order')),
              const PopupMenuItem(child: Text('Logout')),


            ];
          }),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * (1 / 15),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: SearchBar(
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

                  // showPopover(
                  //   height: 70,
                  //     width: 50,
                  //
                  //     context: context,
                  //     bodyBuilder: (ctx) => Column(
                  //       children: [
                  //         Container(width: 50,height: 20,child: Text('Profile',style: TextStyle(color: Colors.white),),color: Colors.green[300],),
                  //         Container(width: 50,height: 20,child: Text('Order',style: TextStyle(color: Colors.white)),color: Colors.green[200],),
                  //         Container(width: 50,height: 20,child: Text('Logout',style: TextStyle(color: Colors.white)),color: Colors.green[100],),
                  //
                  //
                  //
                  //
                  //       ],
                  //     ));
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
