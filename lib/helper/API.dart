import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String URl, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.get(Uri.parse(URl),headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('there is problem in status code${response.statusCode}');
    }
  }

  Future<dynamic> post(
      {required String Url,
      @required dynamic body,
      @required String? token}) async {
    // Map<String, String> headers = {};

    http.Response response = await http.post(Uri.parse(Url), body: body);
    if (response.statusCode == 200) {
      Map<String, String> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'problem in status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String Url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    http.Response response = await http.post(Uri.parse(Url), body: body);
    if (response.statusCode == 200) {
      Map<String, String> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'problem in status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
