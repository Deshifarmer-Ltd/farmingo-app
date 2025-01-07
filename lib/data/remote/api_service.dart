import 'dart:convert';
import 'dart:io';
import 'package:farmingo/app/auth/user_model.dart';
import 'package:farmingo/app/cart/order_model.dart';
import 'package:farmingo/app/cart/user_address_model.dart';
import 'package:farmingo/app/history_order/order_history_details_model.dart';
import 'package:farmingo/app/history_order/order_history_model.dart';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:farmingo/data/remote/model/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = 'https://backend.farmingo.xyz/api/v1';
  static String imageBaseUrl = 'https://backend.farmingo.xyz/storage/';
  static String categoryUrl = '/categories';
  static String categoryProductsUrl = '/category_products';
  static String searchProductsUrl = '/search';
  static String zoneUrl = '/zones';
  static String singleCategoryProductsUrl = '/category_products';
  static String loginUrl = '/login';
  static String userAddressUrl = '/consumer/my_address_book';
  static String registerUrl = '/signup';
  static String orderUrl = '/consumer/order';
  static String resetPassUrl = '/password/reset-request';
  static String userOrderHistoryUrl = '/consumer/my_orders';
  static String userOrderDetailsUrl = '/consumer/my_order/';

//region common apis
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
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
      return null;
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
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
      return null;
    }
  }

  static Future<List<ProductModel>?> getSingleCategoryProducts(int id) async {
    EasyLoading.show(
      status: 'loading...',
    );
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse('$baseUrl$categoryProductsUrl/${id.toString()}');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<ProductModel> items = jsonList
            .map<ProductModel>((jsonItem) => ProductModel.fromJson(jsonItem))
            .toList();
        EasyLoading.dismiss();

        return items;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();

      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));

      return null;
    }
  }

  static Future<List<ZoneModel>?> getZones() async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse('$baseUrl$zoneUrl');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<ZoneModel> items = jsonList
            .map<ZoneModel>((jsonItem) => ZoneModel.fromJson(jsonItem))
            .toList();

        return items;
      } else {
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
      return null;
    }
  }

  static Future<List<ProductModel>?> getSearchedProducts(
      String userInput) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };
    final query = {
      'name': userInput,
    };

    try {
      final url = Uri.parse('$baseUrl$searchProductsUrl')
          .replace(queryParameters: query);
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<ProductModel> items = jsonList
            .map<ProductModel>((jsonItem) => ProductModel.fromJson(jsonItem))
            .toList();

        return items;
      } else {
        EasyLoading.showError(response.body);

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.showError('error: ${e.toString()}');
      return null;
    }
  }

//endregion

//region auth & user related apis
  static Future<List<AddressModel>?> getUserAddresses(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Authorization': token,
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
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
      return null;
    }
  }

  static Future<UserModel?> postLogin(
      {required String emailOrPhone, required String password}) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    EasyLoading.show(
      status: 'loading...',
    );
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
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));

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
    EasyLoading.show(
      status: 'loading...',
    );

    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

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
        EasyLoading.dismiss();

        return model;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
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

    EasyLoading.show(
      status: 'loading...',
    );

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
        EasyLoading.dismiss();

        return message;
      } else {
        EasyLoading.dismiss();

        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();
      EasyLoading.showToast('error: ${e.toString()}',
          duration: Duration(seconds: 4));

      // debugPrint(e());
    }

    return null;
  }

  static Future<String?> postOrder({
    required String token,
    required OrderModel order,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Authorization': token,
    };

    EasyLoading.show(
      status: 'loading...',
    );

    try {
      final url = Uri.parse(baseUrl + orderUrl);
      var response = await http.post(url,
          headers: headers, body: json.encode(order.toJson()));

      if (response.statusCode == HttpStatus.created) {
        var data = json.decode(response.body);

        String message = data['message'] as String;
        EasyLoading.dismiss();
        EasyLoading.showSuccess(message, duration: Duration(seconds: 4));

        return message;
      } else {
        EasyLoading.dismiss();

        EasyLoading.showError(response.body, duration: Duration(seconds: 4));

        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
    }

    return null;
  }

  static Future<List<OrderHistoryModel>?> getUserOrderHistory(
      String token) async {
    EasyLoading.show(
      status: 'loading...',
    );
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Authorization': token,
    };

    try {
      final url = Uri.parse('$baseUrl$userOrderHistoryUrl');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body);

        List<OrderHistoryModel> items = jsonList
            .map<OrderHistoryModel>(
                (jsonItem) => OrderHistoryModel.fromJson(jsonItem))
            .toList();

        EasyLoading.dismiss();

        return items;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
      return null;
    }
  }

  static Future<OrderHistoryDetailsModel?> getOrderDetailsById(
      String token, String orderId) async {
    EasyLoading.show(
      status: 'loading...',
    );
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Authorization': token,
    };

    try {
      final url = Uri.parse('$baseUrl$userOrderDetailsUrl$orderId');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == HttpStatus.ok) {
        var data = json.decode(response.body);

        OrderHistoryDetailsModel model =
            OrderHistoryDetailsModel.fromJson(data);

        EasyLoading.dismiss();

        return model;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(response.body, duration: Duration(seconds: 4));
        return null;
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      EasyLoading.dismiss();
      EasyLoading.showError('error: ${e.toString()}',
          duration: Duration(seconds: 4));
      return null;
    }
  }
//endregion
}
