import 'dart:convert';
import 'dart:io';
import 'package:farmingo/app/auth/user_model.dart';
import 'package:farmingo/app/cart/user_address_model.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

//todo: add loading or toast msg
class ApiService {
  static String baseUrl = 'https://backend.farmingo.xyz/api/v1';
  static String imageBaseUrl = 'https://backend.farmingo.xyz/storage/';

  static String categoryUrl = '/categories';
  static String categoryProductsUrl = '/category_products';
  static String singleCategoryProductsUrl = '/category_products';
  static String loginUrl = '/login';
  static String userAddressUrl = '/consumer/my_address_book';
  static String registerUrl = '/signup';
  static String orderUrl = '/consumer/order';
  static String resetPassUrl = '/password/reset-request';

  static Future<List<CategoryModel>?> getCategories() async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse('$baseUrl$categoryUrl');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<CategoryModel> categories = jsonList
            .map<CategoryModel>((jsonItem) => CategoryModel.fromJson(jsonItem))
            .toList();

        return categories;
      } else {
        Fluttertoast.showToast(
            msg: ' Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return null;
      // Fluttertoast.showToast(msg: 'error: ${e.toString()}');
    }
  }

  static Future<List<ItemModel>?> getAllCategoryProducts() async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse('$baseUrl$categoryProductsUrl');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<ItemModel> items = jsonList
            .map<ItemModel>((jsonItem) => ItemModel.fromJson(jsonItem))
            .toList();

        return items;
      } else {
        Fluttertoast.showToast(
            msg: ' Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return null;
      // Fluttertoast.showToast(msg: 'error: ${e.toString()}');
    }
  }


  static Future<List<AddressModel>?> getUserAddresses(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Authorization':token,
    };

    try {
      final url = Uri.parse('$baseUrl$userAddressUrl');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<AddressModel> items = jsonList
            .map<AddressModel>((jsonItem) => AddressModel.fromJson(jsonItem))
            .toList();

        return items;
      } else {
        Fluttertoast.showToast(
            msg: ' Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return null;
      // Fluttertoast.showToast(msg: 'error: ${e.toString()}');
    }
  }

  static Future<List<ProductModel>?> getSingleCategoryProducts(int id) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    // https://backend.farmingo.xyz/api/v1/category_products/1

    try {
      final url = Uri.parse('$baseUrl$categoryProductsUrl/${id.toString()}');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<ProductModel> items = jsonList
            .map<ProductModel>((jsonItem) => ProductModel.fromJson(jsonItem))
            .toList();

        return items;
      } else {
        Fluttertoast.showToast(
            msg: ' Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return null;
      // Fluttertoast.showToast(msg: 'error: ${e.toString()}');
    }
  }

  static Future<UserModel?> postLogin(
      {required String emailOrPhone, required String password}) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };
    //todo: need to fix this easy loading and dialogue issue

    EasyLoading.show(status: 'loading...',);
    try {
      final url = Uri.parse(baseUrl + loginUrl);
      var response = await http.post(url,
          headers: headers,
          body: json.encode({'password': password, 'email': emailOrPhone}));

      if (response.statusCode == HttpStatus.ok) {
        var data = json.decode(response.body);
        UserModel model = UserModel.fromJson(data);
        EasyLoading.dismiss();
        return model;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(response.body);

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();
      EasyLoading.showError( 'error: ${e.toString()}');

      // debugPrint(e());
    }

    return null;
  }

  static Future<UserModel?> postRegistration({
    required String name,
    required String email,
    required String phone,
    required String password,
    required int zoneId,
    required String address,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    // EasyLoading.show(status: 'loading...');

    try {
      final url = Uri.parse(baseUrl + registerUrl);
      var response = await http.post(url,
          headers: headers,
          body: json.encode({
            "name": name,
            "email": email,
            "phone": phone,
            "password": password,
            "zone_id": zoneId,
            "address": address,
            "emailOrPhone": ""
          }));

      if (response.statusCode >= HttpStatus.created) {
        var data = json.decode(response.body);
        UserModel model = UserModel.fromJson(data);
        return model;
      } else {
        Fluttertoast.showToast(
            msg: ' Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      // EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'error: ${e.toString()}');

      // debugPrint(e());
    }

    return null;
  }

  static Future<String?> postResetPassword({
    required String phone,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    EasyLoading.show(status: 'loading...',);

    try {
      final url = Uri.parse(baseUrl + resetPassUrl);
      var response = await http.post(url,
          headers: headers,
          body: json.encode({
            "email": phone,

          }));

      if (response.statusCode == HttpStatus.ok) {
        var data = json.decode(response.body);

        String message = data['message'] as String;

        return message;
      } else {
        EasyLoading.showError(response.body);

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      // EasyLoading.dismiss();
      EasyLoading.showToast( 'error: ${e.toString()}');

      // debugPrint(e());
    }




    return null;
  }
}
