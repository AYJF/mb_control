import 'dart:convert' as convert; // for the utf8.encode method
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mb_control/models/client_model.dart';
import 'package:mb_control/models/company.dart';
import 'package:mb_control/models/model.dart';
import 'package:mb_control/models/operation.dart';
import 'package:mb_control/models/promoter.dart';
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

  Future<List<Promoter>> getPromoters({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/promoter"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? promoterModelFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<UserClient>> getClients({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/client"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? clientModelFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Company>> getCompanies({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/company"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? companyFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Operation>> getOperations({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/operation"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      print(response.statusCode);
      return response.statusCode == 200
          ? operationFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Model>> getModel({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/model"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? modelFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
