import 'package:farmingo/data/remote/api_service.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ItemModel> categoryProducts = <ItemModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCategories();
    fetchCategoryProducts();
  }

  fetchCategories() async {
    var items = await ApiService.getCategories();
    categories.assignAll(items ?? []);
  }

  fetchCategoryProducts() async {
    var items = await ApiService.getCategoryProducts();
    categoryProducts.assignAll(items ?? []);
  }
}
