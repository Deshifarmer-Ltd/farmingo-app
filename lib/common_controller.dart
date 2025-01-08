import 'package:farmingo/app/history_order/order_history_details_model.dart';
import 'package:farmingo/app/history_order/order_history_model.dart';
import 'package:farmingo/app/home/cart_item_model.dart';
import 'package:farmingo/data/remote/api_service.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:farmingo/data/remote/model/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/conts_data.dart';
import 'common/shred_pref.dart';
import 'common/style.dart';
import 'common/utils.dart';

class CommonController extends GetxController {
  String selectedAllProductCategoryTitle = '';
  RxList<ProductModel> selectedAllProductList = <ProductModel>[].obs;
  RxList<ProductModel> searchedProductList = <ProductModel>[].obs;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ItemModel> categoryProducts = <ItemModel>[].obs;
  RxList<ZoneModel> zoneModels = <ZoneModel>[].obs;
  Rxn<ZoneModel> selectedZone = Rxn<ZoneModel>();
  RxList<CartItemModel> cartItemList = <CartItemModel>[].obs;
  RxList<OrderHistoryModel> orderHistoryList = <OrderHistoryModel>[].obs;
  Rxn<OrderHistoryDetailsModel> orderDetailsHistory =
      Rxn<OrderHistoryDetailsModel>();

  final TextEditingController searchCtr = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchZone();
    fetchCategories();
    fetchCategoryProducts();

    selectedZone.listen((model) {
      if (model != null) {
        SharedPrefs().saveInt(zoneId, model.id);
      }
    });
  }

  fetchCategories() async {
    if (await Util.checkInternet() == false) {
      return;
    }
    var items = await ApiService.getCategories();
    categories.assignAll(items ?? []);
  }

  fetchZone() async {
    if (await Util.checkInternet() == false) {
      return;
    }

    int zone = SharedPrefs().getInt(zoneId) ?? 0;
    var items = await ApiService.getZones();
    zoneModels.assignAll(items ?? []);

    // if already has zoneId then set the zoneModel
    if (items != null && zone > 0) {
      for (var i in items) {
        if (zone == i.id) {
          selectedZone.value = i;
          break;
        }
      }
    }
    // if not set zone id then auto open dialog
    if (items != null && zone == 0 && Get.context != null) {
      buildZoneDialog();
    }
  }

  fetchCategoryProducts() async {
    if (await Util.checkInternet() == false) {
      return;
    }

    var items = await ApiService.getAllCategoryProducts();
    categoryProducts.assignAll(items ?? []);
  }

  fetchSingleCategoryProductsById(int id) async {
    if (await Util.checkInternet() == false) {
      return;
    }

    selectedAllProductList.clear();
    var items = await ApiService.getSingleCategoryProducts(id);
    selectedAllProductList.assignAll(items ?? []);
    // categoryProducts.assignAll(items ?? []);
  }

  fetchUserOrderHistory() async {
    if (await Util.checkInternet() == false) {
      return;
    }

    var items = await ApiService.getUserOrderHistory(
        SharedPrefs().getString(token) ?? '');
    orderHistoryList.assignAll(items ?? []);
  }

  fetchOrderDetailsById(String id) async {
    if (await Util.checkInternet() == false) {
      return;
    }

    OrderHistoryDetailsModel? data = await ApiService.getOrderDetailsById(
        SharedPrefs().getString(token) ?? '', id);
    if (data != null) {
      orderDetailsHistory.value = data;
    }
  }

  fetchSearchProducts(String name) async {
    if (await Util.checkInternet() == false) {
      return;
    }

    var items = await ApiService.getSearchedProducts(name);
    searchedProductList.assignAll(items ?? []);
  }

  Future<dynamic>? buildZoneDialog() {
    if (Get.context != null) {
      return



        showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (ctx) {
              return PopScope(
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        'select a zone',
                        style: MStyle.value1Style,
                      ),
                      ...List.generate(zoneModels.length, (i) {
                        ZoneModel model = zoneModels.elementAt(i);

                        return TextButton(
                          child: Text(model.name),
                          onPressed: () {
                            selectedZone.value = model;
                            Navigator.pop(ctx);
                          },
                        );
                      })
                    ]),
                  ),
                ),
                canPop: false,
              );
            });
    } else {
      return null;
    }
  }
}
