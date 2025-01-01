import 'package:farmingo/app/auth/auth_controller.dart';
import 'package:farmingo/app/home/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_routes.dart';

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
controller.fetchUserOrderHistory();
                    Get.toNamed(AppRoutes.loginPath);
                  },
                  icon: const Icon(
                    Icons.person_2_outlined,
                  ))
              :   PopupMenuButton(icon: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text(ctr.userName.value,style: const TextStyle(color: Colors.white),),
                        ),itemBuilder: (ctx) {

//todo: need this menu dynamic
            return [
              // const PopupMenuItem(child: Text('Profile')),
               PopupMenuItem(child: Text('Order'),onTap: (){

                 Get.toNamed(AppRoutes.orderHistoryPath);



               },),
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
