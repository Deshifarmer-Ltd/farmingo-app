
import 'package:farmingo/app/home/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/routes/app_routes.dart';

class CustomAppbar extends GetView<CommonController> {
  const CustomAppbar({super.key});
  //todo: make hint / font size dynamic for all screen

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {

              // Navigator.push(context, MaterialPageRoute(builder: (_)=>TestPage()));

            },
            icon: const Icon(
              Icons.person_2_outlined,
            )),
         Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height* (1/15),
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
            label:  Obx((){
              return   Text(controller.cartItemList.length.toString());

    }) ,
            child: IconButton(
              onPressed: (){

                Get.toNamed(AppRoutes.cartPath);
              },

              icon: const Icon(Icons.shopping_cart_outlined,color: Colors.green,),
            ),
          ),
        ),
      ],
    );
  }
}
