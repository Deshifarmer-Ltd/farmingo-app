import 'package:farmingo/app/auth/user_model.dart';
import 'package:farmingo/app/cart/order_model.dart';
import 'package:farmingo/app/cart/user_address_model.dart';
import 'package:farmingo/app_routes.dart';
import 'package:farmingo/common_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../common/conts_data.dart';
import '../../common/shred_pref.dart';
import '../../data/remote/api_service.dart';

class AuthController extends GetxController {
  RxInt sliderButtonNumber = 0.obs; // saved address=0 & new Address =1

  //login fields
  TextEditingController loginPassword = TextEditingController();
  TextEditingController loginNameOrEmail = TextEditingController();

  //register fields
  TextEditingController regName = TextEditingController();
  TextEditingController regEmail = TextEditingController();
  TextEditingController regPhone = TextEditingController();
  TextEditingController regAddress = TextEditingController();
  TextEditingController regPass = TextEditingController();

  //reset password fields
  TextEditingController resetPhoneNumber = TextEditingController();

  //different address/name/phone number fields
  TextEditingController diffName = TextEditingController();
  TextEditingController diffPhone = TextEditingController();
  TextEditingController diffAddress = TextEditingController();

  RxBool isPassObscure = true.obs;
  RxList<AddressModel> addressList = <AddressModel>[].obs;
  Rxn<AddressModel> selectedAddress = Rxn<AddressModel>();

  Rxn<UserModel> user = Rxn<UserModel>();
  RxString userName = ''.obs;
  RxBool isUserLoggedIn = false.obs;

  final diffAddressFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    isUserLoggedIn.value = SharedPrefs().getBool(isLoggedIn) ?? false;

    if(isUserLoggedIn.value)
      {
        setFirstLetterOfName(SharedPrefs().getString(loginUserName)??'x');
        fetchUserAddress();

      }

  }

  Future<bool> doLogin() async {
    user.value = await ApiService.postLogin(
        emailOrPhone: loginNameOrEmail.text, password: loginPassword.text);

    if (user.value != null) {
      setFirstLetterOfName(user.value!.name);
      isUserLoggedIn.value = true;
      saveUserCredToPref();
      fetchUserAddress();

      return true;
    } else {
      return false;
    }
  }

  Future<bool> doRegister() async {
    user.value = await ApiService.postRegistration(
      name: regName.text,
      email: regEmail.text,
      phone: regPhone.text,
      password: regPass.text,
      zoneId: SharedPrefs().getInt(zoneId) ?? 1,
      address: regAddress.text,
    );

    if (user.value != null) {
      setFirstLetterOfName(user.value!.name);
      fetchUserAddress();

      return true;
    } else {
      return false;
    }
  }

  Future<String?> resetPassword() async {
    var message = await ApiService.postResetPassword(
      phone: resetPhoneNumber.text,
    );

    return message;
  }

  fetchUserAddress() async {
    var items =
        await ApiService.getUserAddresses(SharedPrefs().getString(token) ?? '');
    addressList.assignAll(items ?? []);
    selectedAddress.value = addressList.first;
  }

  void setFirstLetterOfName(String name) {
    userName.value = name
        .trim()[0]
        .toUpperCase(); // Take the first character and convert it to uppercase
  }

  //region Order related method

  void validateDifferentAddress() {
    if (diffAddressFormKey.currentState!.validate()) {
      postUserOrder(
          deliveryInfo: DeliveryInfo(
              name: diffName.text,
              address: diffAddress.text,
              phone: diffPhone.text));
    }
  }

  void validateAddressBook() {
    if (selectedAddress.value != null) {
      postUserOrder(addressId: selectedAddress.value!.id);
    }
  }

  void postUserOrder({DeliveryInfo? deliveryInfo, int? addressId}) async {
    CommonController commonController = Get.find<CommonController>();

    List<Product> orderProducts = [];

    for (var model in commonController.cartItemList) {
      Product p =
          Product(productId: model.product.id, quantity: model.count.value);
      orderProducts.add(p);
    }

    OrderModel orderModel = OrderModel(
        zoneId: SharedPrefs().getInt(zoneId) ?? 1,
        products: orderProducts,
        deliveryAddressId: addressId,
        deliveryCharge: 50,
        deliveryInfo: deliveryInfo);

    String? message = await ApiService.postOrder(
        token: SharedPrefs().getString(token) ?? '', order: orderModel);

    commonController.cartItemList.clear();


    Navigator.pop(Get.context!);

    // Get.offAll(AppRoutes.homePath);

  }

  //endregion

  void saveUserCredToPref() {
    SharedPrefs().saveInt(loginUserId, user.value!.id);
    SharedPrefs().saveBool(isLoggedIn, true);
    SharedPrefs().saveString(loginUserName, user.value!.name);
    SharedPrefs().saveString(loginUserEmail, user.value!.email);
    SharedPrefs().saveString(token, 'Bearer ${user.value!.token}');
  }

  void clearUserCredFromPref() {
  // Can not call clear method because it clear all values
  // but App need to have zoneId
  // for that reason key wise single remove
    SharedPrefs().remove(loginUserId);
    SharedPrefs().remove(isLoggedIn);
    SharedPrefs().remove(loginUserName);
    SharedPrefs().remove(loginUserEmail);
    SharedPrefs().remove(token);
    user.value = null;
    isUserLoggedIn.value = false;
  }
}
