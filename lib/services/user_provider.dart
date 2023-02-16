import 'package:flutter/material.dart';
import 'package:mb_control/models/client_model.dart';
import 'package:mb_control/models/model.dart';
import 'package:mb_control/models/operation.dart';
import 'package:mb_control/models/promoter.dart';
import 'package:mb_control/models/user.dart';
import 'package:mb_control/services/mb_services.dart';

class UserHndl with ChangeNotifier {
  String? _promoterID = "";
  String? get promoterID => this._promoterID;

  List<Map> _models = [];
  List<Map> get models => this._models;

  set models(List<Map> value) {
    this._models = value;
    notifyListeners();
  }

  set promoterID(String? value) {
    this._promoterID = value;
    notifyListeners();
  }

  User _user = User.empty;
  User get user => this._user;

  set user(User value) => this._user = value;

  final MbService mbService = MbService();

  String _email = '';
  String get email => this._email;

  set email(String value) {
    this._email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => this._password;

  bool _isLoading = false;
  get isLoading => this._isLoading;

  set isLoading(value) {
    this._isLoading = value;
    notifyListeners();
  }

  set password(String value) {
    this._password = value;
    notifyListeners();
  }

  Future<bool> login() async {
    _user = await mbService.login(email: _email, password: _password);
    return _user.token != null ? true : false;
  }

  Future<List<Promoter>> getPromoters() async {
    return _user.token != null
        ? await mbService.getPromoters(token: _user.token!)
        : [];
  }

  Future<List<UserClient>> getClients() async {
    return _user.token != null
        ? await mbService.getClients(token: _user.token!)
        : [];
  }

  Future<List<Operation>> getOperations() async {
    return _user.token != null
        ? await mbService.getOperations(token: _user.token!)
        : [];
  }

  Future<List<Model>> getModels() async {
    _models.clear();
    final List<Model> dbModels = _user.token != null
        ? await mbService.getModel(token: _user.token!)
        : [];

    models.addAll(
        dbModels.map((e) => {"modelId": e.id, "hasIva": false, "value": 0}));
    return dbModels;
  }
}
