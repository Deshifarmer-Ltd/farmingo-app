import 'package:farmingo/app/all_product/all_product_page.dart';
import 'package:get/get.dart';
import '../home/home_page.dart';


class AppRoutes {

  static const String homePath = '/home_page';
  static const String allProductListPath = '/product_page';
  static const String productDetailsPath = '/product_details_page';
  static const String locationPath = '/location_page';
  static const String searchResultPath = '/search_result_page';
  static const String cartPath = '/cart_page';
  static const String checkoutPath = '/checkout_page';

  static const String onTheGoPath = '/on_the_go_page';
  static const String preOwnedPath = '/pre_owned_page';
  static const String testPath = '/test_page';
  static const String goggleSignInPath = '/goggleSignIn_page';
  static const String userAccountPath = '/user_account__page';

  static final routes = [
 GetPage(
      name: homePath,
      page: () => const HomePage(),

    ),
    // GetPage(
    //     name: productDetailsPath,
    //     page: () => ProductDetailsPage(),
    //     binding: ProductDetailsBindings()),
    GetPage(
        name: allProductListPath,
        page: () => const AllProductPage(),
        // binding: AllProductBinding()

  ),


    // GetPage(
    //     name: searchResultPath,
    //     page: () => const SearchResultPage(),
    //     binding: SearchBindings()),
    //
    // GetPage(
    //   name: cartPath,
    //   page: () => const CartPage(),
    //   binding: CartBinding(),
    // ),
    //
    // GetPage(
    //   name: checkoutPath,
    //   page: () =>  CheckoutPage(),
    //   //no binding needed as it will use cartController
    // ),
    //
    // ///tabs
    // GetPage(
    //     name: onTheGoPath,
    //     page: () => const OnTheGoPage(),
    //     binding: OnTheGoBinding()),
    // GetPage(
    //     name: preOwnedPath,
    //     page: () => const PreOwnedPage(),
    //     binding: PreOwnedBindings()),
    //
    // ///side buttons
    // GetPage(
    //     name: locationPath,
    //     page: () => const LocationPage(),
    //     // binding: LocationBindings()
    //
    // ),
    //
    // GetPage(
    //   name: testPath,
    //   page: () => const TestPage(),
    // ),
    //
    // GetPage(
    //   name: goggleSignInPath,
    //   page: () =>  SignInPage(),
    //   binding: AuthBinding(),
    // ),
    //
    // GetPage(
    //   name: userAccountPath,
    //   page: () =>  UserAccountPage(),
    //   binding: AuthBinding(),
    // ),
  ];
}