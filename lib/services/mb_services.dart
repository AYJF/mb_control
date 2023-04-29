import 'dart:convert' as convert; // for the utf8.encode method
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mb_control/models/client_model.dart';
import 'package:mb_control/models/company.dart';
import 'package:mb_control/models/invoice.dart';
import 'package:mb_control/models/model.dart';
import 'package:mb_control/models/operation.dart';
import 'package:mb_control/models/promoter.dart';
import 'package:mb_control/models/provider_income.dart';
import 'package:mb_control/models/provider_outcome.dart';
import 'package:mb_control/models/user.dart';
import 'package:mb_control/models/users.dart';

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

  Future<List<Users>> getUsers({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/user"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? usersFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Invoice>> getInvoices({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/invoice"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? invoiceFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<ProviderIcome>> getProviderIncome({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/providerInCome"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? providerIncomeFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<ProviderOutcome>> getProviderOutcome(
      {required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/providerOutCome"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? providerOutcomeFromJson(convert.jsonDecode(response.body))
          : [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<String> getOperationNextFolio(
      {required String token, required String userEmail}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/operation/nextFolio/$userEmail"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
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

  Future<List<Operation>> getOperations({
    required String token,
    String email = '',
    String startDate = '',
    String endDate = '',
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            "$_apiBaseUrl/operation?email=$email&startDate=$startDate&endDate=$endDate"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

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

  Future<Model> getModelbyId(
      {required String token, required String id}) async {
    try {
      final response = await http.get(
        Uri.parse("$_apiBaseUrl/model/$id"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      return response.statusCode == 200
          ? Model.fromJson(convert.jsonDecode(response.body))
          : Model.empty;
    } catch (e) {
      debugPrint(e.toString());
      return Model.empty;
    }
  }

  Future<bool> createClient(
      {required Map<String, dynamic> body, required String token}) async {
    try {
      final response = await http.post(Uri.parse("$_apiBaseUrl/client"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer $token"
          },
          body: convert.jsonEncode(body));

      return response.statusCode == 204 ? true : false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> createPromoter(
      {required Map<String, dynamic> body, required String token}) async {
    try {
      final response = await http.post(Uri.parse("$_apiBaseUrl/promoter"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer $token"
          },
          body: convert.jsonEncode(body));

      return response.statusCode == 204 ? true : false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> createProviderInCome(
      {required Map<String, dynamic> body, required String token}) async {
    try {
      final response = await http.post(Uri.parse("$_apiBaseUrl/providerInCome"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer $token"
          },
          body: convert.jsonEncode(body));

      return response.statusCode == 204 ? true : false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> createComision(
      {required Map<String, dynamic> body, required String token}) async {
    try {
      final response =
          await http.post(Uri.parse("$_apiBaseUrl/operation/calculator"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                "Authorization": "Bearer $token"
              },
              body: convert.jsonEncode(body));

      return response.statusCode == 204 ? true : false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
