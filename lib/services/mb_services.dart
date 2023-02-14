import 'dart:convert' as convert; // for the utf8.encode method
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mb_control/models/user.dart';

class MbService {
  final String _apiBaseUrl = 'https://mb-control.azurewebsites.net/';

  Future<User> login({required String email, required String password}) async {
    try {
      final response = await http.post(Uri.parse("$_apiBaseUrl/user/login"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: convert.jsonEncode({
            'email': email,
            'password': password,
          }));
      return response.statusCode == 200
          ? User.fromJson(convert.jsonDecode(response.body))
          : User.empty;
    } catch (e) {
      debugPrint(e.toString());
      return User.empty;
    }
  }
}

// final Map<String, String> _header = {
//     "Accept-Encoding": "gzip",
//     'Content-type': 'application/json',
//     'Accept': 'application/json',
//     "Duffel-Version": "v1",
//     "Authorization":
//         "Bearer duffel_test_hlYn3VXLzLmgvsFeYnKFC1ouqznBCI-zBbgSGySFXn1"
//   };