import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Util{



 static Future<bool>  checkInternet() async {
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