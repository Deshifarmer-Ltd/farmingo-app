import 'package:farmingo/app/all_product/all_product_page.dart';
import 'package:farmingo/app/auth/auth_binding.dart';
import 'package:farmingo/app/auth/forget_pass_page.dart';
import 'package:farmingo/app/auth/login_page.dart';
import 'package:farmingo/app/auth/registration_page.dart';
import 'package:farmingo/app/cart/cart_page.dart';
import 'package:farmingo/app/test_page.dart';
import 'package:get/get.dart';
import 'app/home/home_page.dart';

class AppRoutes {
  static const String homePath = '/home_page';
  static const String testPath = '/test_page';
  static const String allProductListPath = '/product_page';
  static const String cartPath = '/cart_page';
  static const String loginPath = '/login_page';
  static const String registrationPath = '/registration_page';
  static const String forgetPassPath = '/forget_pass_page';

  static final routes = [
    GetPage(
      name: homePath,
      page: () => const HomePage(),
    ),
    GetPage(
      name: allProductListPath,
      page: () => const AllProductPage(),
    ),

    GetPage(
      name: cartPath,
      page: () =>  CartPage(),
    ),

    GetPage(
      name: loginPath,
      page: () =>  LoginPage(),
      binding: AuthBinding()
    ),

    GetPage(
      name: registrationPath,
      page: () =>  RegistrationPage(),
      binding: AuthBinding()
    ),

    GetPage(
      name: forgetPassPath,
      page: () =>  ForgetPassPage(),
      binding: AuthBinding()
    ),

    GetPage(
      name: testPath,
      page: () =>  TestPage(),
    ),


  ];
}
