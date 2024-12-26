import 'package:farmingo/app/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/remote/api_service.dart';

class AuthController extends GetxController {
  TextEditingController loginPassword = TextEditingController();
  TextEditingController loginNameOrEmail = TextEditingController();

  TextEditingController regName = TextEditingController();
  TextEditingController regEmail = TextEditingController();
  TextEditingController regPhone = TextEditingController();
  TextEditingController regAddress = TextEditingController();
  TextEditingController regPass = TextEditingController();

  RxBool isPassObscure = true.obs;
  Rxn<UserModel> user = Rxn<UserModel>();
  RxString userName = ''.obs;
  RxBool isLoginPage = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> doLogin() async {
    user.value = await ApiService.postLogin(
        emailOrPhone: loginNameOrEmail.text, password: loginPassword.text);

    if (user.value != null) {
      setFirstLetterOfName(user.value!.name);
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
      zoneId: 1,//todo:zone id need to set dynamic
      address: regAddress.text,
    );

    if (user.value != null) {
      setFirstLetterOfName(user.value!.name);
      return true;
    } else {
      return false;
    }
  }

  void setFirstLetterOfName(String name) {
    userName.value = name
        .trim()[0]
        .toUpperCase(); // Take the first character and convert it to uppercase
  }
}
