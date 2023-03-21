import 'package:flutter/material.dart';
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
import 'package:mb_control/services/mb_services.dart';

class UserHndl with ChangeNotifier {
  DateTime? startDateTime;
  DateTime? endDateTime;

  String? linkerEmail = '';
  String? _promoterID = "";
  String? get promoterID => this._promoterID;

  List<Map> _models = [];
  List<Map> get models => this._models;

  bool _contactByEmail = false;
  bool get contactByEmail => this._contactByEmail;

  set contactByEmail(bool value) {
    this._contactByEmail = value;
    notifyListeners();
  }

  int _wInvoice = 0;
  int get wInvoice => this._wInvoice;

  set wInvoice(int value) {
    this._wInvoice = value;
    notifyListeners();
  }

  int _total = 0;
  int get total => this._total;

  set total(int value) {
    this._total = value;
    notifyListeners();
  }

  bool _contactByPhone = false;
  bool get contactByPhone => this._contactByPhone;

  set contactByPhone(bool value) {
    this._contactByPhone = value;
    notifyListeners();
  }

  set models(List<Map> value) {
    this._models = value;
    notifyListeners();
  }

  set promoterID(String? value) {
    this._promoterID = value;
    // notifyListeners();
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

  String _rfc = "";
  String get rfc => this._rfc;

  set rfc(String value) {
    this._rfc = value;
    notifyListeners();
  }

  String _name = "";
  String get name => this._name;

  set name(String value) {
    this._name = value;
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

  void clearOperations() {
    linkerEmail = '';
    startDateTime = null;
    endDateTime = null;
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

  Future<List<Invoice>> getInvoices() async {
    return _user.token != null
        ? await mbService.getInvoices(token: _user.token!)
        : [];
  }

  Future<List<ProviderIcome>> getProviderIncome() async {
    return _user.token != null
        ? await mbService.getProviderIncome(token: _user.token!)
        : [];
  }

  Future<List<ProviderOutcome>> getProviderOutcome() async {
    return _user.token != null
        ? await mbService.getProviderOutcome(token: _user.token!)
        : [];
  }

  Future<List<Users>> getUsers() async {
    return _user.token != null
        ? await mbService.getUsers(token: _user.token!)
        : [];
  }

  Future<List<UserClient>> getClients() async {
    return _user.token != null
        ? await mbService.getClients(token: _user.token!)
        : [];
  }

  Future<List<Operation>> getOperations() async {
    return _user.token != null
        ? await mbService.getOperations(
            token: _user.token!,
            email: linkerEmail ?? "",
            startDate: startDateTime == null ? "" : startDateTime.toString(),
            endDate: endDateTime == null ? "" : endDateTime.toString(),
          )
        : [];
  }

  Future<List<Company>> getCompanies() async {
    return _user.token != null
        ? await mbService.getCompanies(token: _user.token!)
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

  Future<bool> createClient() async {
    final Map<String, dynamic> body = {
      "name": _name,
      "userEmail": _user.email,
      "rfc": _rfc,
      "promoterId": _promoterID,
      "models": _models,
    };

    return mbService.createClient(body: body, token: _user.token!);
  }
}
