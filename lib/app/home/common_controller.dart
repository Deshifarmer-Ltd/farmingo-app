import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmingo/app/history_order/order_history_model.dart';
import 'package:farmingo/app/home/cart_item_model.dart';
import 'package:farmingo/data/remote/api_service.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/conts_data.dart';
import '../../common/shred_pref.dart';

class CommonController extends GetxController {
  String selectedAllProductCategoryTitle = '';
  RxList<ProductModel> selectedAllProductList = <ProductModel>[].obs;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ItemModel> categoryProducts = <ItemModel>[].obs;
  RxList<CartItemModel> cartItemList = <CartItemModel>[].obs;
  RxList<OrderHistoryModel> orderHistoryList = <OrderHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchCategoryProducts();

  }

  fetchCategories() async {
    // checkInternet();
    var items = await ApiService.getCategories();
    categories.assignAll(items ?? []);
  }

  fetchCategoryProducts() async {
    var items = await ApiService.getAllCategoryProducts();
    categoryProducts.assignAll(items ?? []);
  }



  fetchSingleCategoryProductsById(int id) async {
    selectedAllProductList.clear();
    var items = await ApiService.getSingleCategoryProducts(id);
    selectedAllProductList.assignAll(items ?? []);
    // categoryProducts.assignAll(items ?? []);
  }




  Future<bool> checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      Get.rawSnackbar(
          backgroundColor: Colors.redAccent,
          message: "Internet connection is not available",
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP);
      return false;
    }
  }



  void getUserDataCredFromPref() {

    // SharedPrefs().saveInt(loginUserId, user.value!.id);
    SharedPrefs().getString(loginUserName);
    SharedPrefs().getString(loginUserEmail);
    SharedPrefs().getString(loginUserPhone);


  }


  fetchUserOrderHistory() async {
    var items = await ApiService.getUserOrderHistory(SharedPrefs().getString(token) ?? '');
    orderHistoryList.assignAll(items ?? []);
  }





}
