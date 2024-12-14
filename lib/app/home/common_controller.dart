import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmingo/app/home/cart_item_model.dart';
import 'package:farmingo/data/remote/api_service.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  String selectedAllProductCategoryTitle = '';
  RxList<ProductModel> selectedAllProductList = <ProductModel>[].obs;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ItemModel> categoryProducts = <ItemModel>[].obs;
  RxList<CartItemModel> cartItemList = <CartItemModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
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
}
