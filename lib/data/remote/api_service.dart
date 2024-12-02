import 'dart:convert';
import 'package:farmingo/data/remote/model/category_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

//todo: add loading or toast msg
class ApiService {
  static String baseUrl = 'https://backend.farmingo.xyz/api/v1';
  static String imageBaseUrl = 'https://backend.farmingo.xyz/storage/';

  static String categoryUrl = '/categories';
  static String categoryProductsUrl = '/category_products';


  static Future<List<CategoryModel>?>  getCategories() async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse('$baseUrl$categoryUrl');
      var response = await http.get(url, headers: headers);


      if (response.statusCode == 200) {
        var jsonList = json.decode(response.body);

        List<CategoryModel> categories =
        jsonList.map<CategoryModel>((jsonItem) => CategoryModel.fromJson(jsonItem)).toList();

        return categories;

      }

        else {
          // Fluttertoast.showToast(msg: '${model.status_code} ${model.msg}');
          return null;

      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return null;
      // Fluttertoast.showToast(msg: 'error: ${e.toString()}');

    }



  }
  static Future<List<ItemModel>?>  getCategoryProducts() async {
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse('$baseUrl$categoryProductsUrl');
      var response = await http.get(url, headers: headers);


      if (response.statusCode == 200) {
        var jsonList = json.decode(response.body);

        List<ItemModel> items =
        jsonList.map<ItemModel>((jsonItem) => ItemModel.fromJson(jsonItem)).toList();

        return items;

      }

        else {
          // Fluttertoast.showToast(msg: '${model.status_code} ${model.msg}');
          return null;

      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return null;
      // Fluttertoast.showToast(msg: 'error: ${e.toString()}');

    }



  }





}
