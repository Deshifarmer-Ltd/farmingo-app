import 'package:farmingo/app/auth/user_model.dart';
import 'package:farmingo/app/cart/user_address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../common/conts_data.dart';
import '../../common/shred_pref.dart';
import '../../data/remote/api_service.dart';

class AuthController extends GetxController {
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

  RxBool isPassObscure = true.obs;
  RxList<AddressModel> addressList = <AddressModel>[].obs;
  Rxn<AddressModel> selectedAddress=Rxn<AddressModel>();

  Rxn<UserModel> user = Rxn<UserModel>();
  RxString userName = ''.obs;
  RxBool isLoginPage = true.obs;
  RxBool isUserLoggedIn = false.obs;


  // @override
  // void onInit() {
  //   isUserLoggedIn.listen((value){
  //     if(value==true)
  //       {
  //         fetchUserAddress();
  //       }
  //
  //
  //   });
  // }

  Future<bool> doLogin() async {
    user.value = await ApiService.postLogin(
        emailOrPhone: loginNameOrEmail.text, password: loginPassword.text);

    if (user.value != null) {
      setFirstLetterOfName(user.value!.name);
      isUserLoggedIn.value=true;
      fetchUserAddress();
      saveUserCredToPref();

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
      zoneId: 1,
      //todo:zone id need to set dynamic
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

  void saveUserCredToPref() {
    SharedPrefs().saveInt(loginUserId, user.value!.id);
    SharedPrefs().saveString(loginUserName, user.value!.name);
    SharedPrefs().saveString(loginUserEmail, user.value!.email);
    SharedPrefs().saveString(token, 'Bearer ${user.value!.token}');
    SharedPrefs().saveBool(isLoggedIn, true);
  }
}
