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
  Operation? _operation;
  Operation? get operation => _operation;

  String _invoiceNumber = '';
  String get invoiceNumber => _invoiceNumber;

  String _operationNextFolio = '';
  String get operationNextFolio => _operationNextFolio;

  set operationNextFolio(String value) {
    _operationNextFolio = value;
    notifyListeners();
  }

  set invoiceNumber(String value) {
    _invoiceNumber = value;
    notifyListeners();
  }

  String _invoiceAmount = '';
  get invoiceAmount => _invoiceAmount;

  set invoiceAmount(value) {
    _invoiceAmount = value;
    notifyListeners();
  }

  set operation(Operation? value) {
    _operation = value;
    notifyListeners();
  }

  void setOperation(Operation? value) {
    _operation = value;
  }

  bool _providerFactura = true;
  bool get providerFactura => _providerFactura;
  set providerFactura(bool value) {
    _providerFactura = value;
    notifyListeners();
  }

  bool _providerWithOutFactura = true;
  bool get providerWithOutFactura => _providerWithOutFactura;

  set providerWithOutFactura(bool value) {
    _providerWithOutFactura = value;
    notifyListeners();
  }

  String _invoiceId = '';
  String get invoiceId => _invoiceId;

  set invoiceId(String value) {
    _invoiceId = value;
    notifyListeners();
  }

  String _companyId = '';
  String get companyId => _companyId;

  set companyId(String value) {
    _companyId = value;
    notifyListeners();
  }

  String _providerName = '';
  String get providerName => _providerName;

  set providerName(String value) {
    _providerName = value;
    notifyListeners();
  }

  String _costoFactura = '';
  String get costoFactura => _costoFactura;

  set costoFactura(String value) {
    _costoFactura = value;
    notifyListeners();
  }

  String _costoWithoutFactura = '';
  String get costoWithoutFactura => _costoWithoutFactura;

  set costoWithoutFactura(String value) {
    _costoWithoutFactura = value;
    notifyListeners();
  }

  DateTime? startDateTime;
  DateTime? endDateTime;

  String _clientID = '';
  String get clientID => _clientID;

  set clientID(String value) {
    _clientID = value;
    notifyListeners();
  }

  String _modelID = '';
  String get modelID => this._modelID;

  set modelID(String value) {
    _modelID = value;
    notifyListeners();
  }

  String? linkerEmail = '';
  String? _promoterID = "";
  String? get promoterID => this._promoterID;

  List<Map> _operationsModels = [];
  List<Map> get operationsModels => this._operationsModels;

  set operationsModels(List<Map> oper) {
    _operationsModels = oper;
    notifyListeners();
  }

  List<Map> _models = [];
  List<Map> get models => this._models;

  List<Map> _modelsPromoters = [];
  List<Map> get modelsPromoters => this._modelsPromoters;

  bool _contactByEmail = false;
  bool get contactByEmail => this._contactByEmail;

  set contactByEmail(bool value) {
    this._contactByEmail = value;
    notifyListeners();
  }

  double _totalOperation = 0;
  double get totalOperation => this._totalOperation;

  set totalOperation(double value) {
    this._totalOperation = value;
    notifyListeners();
  }

  int _realVirtual = 0;
  int get realVirtual => this._realVirtual;

  set realVirtual(int value) {
    this._realVirtual = value;
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
  String get email => _email;

  String _phone = '';
  String get phone => _phone;

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
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
    if (_user.token != null) {
      final promotores = await mbService.getPromoters(token: _user.token!);

      _promoterID = promotores.first.id!;
      return promotores;
    } else {
      return [];
    }
  }

  Future<List<Invoice>> getInvoices() async {
    if (_user.token != null) {
      final invoices = await mbService.getInvoices(token: _user.token!);

      _invoiceId = invoices.first.id!;
      return invoices;
    } else {
      return [];
    }
  }

  Future<List<ProviderIcome>> getProviderIncome() async {
    return _user.token != null
        ? await mbService.getProviderIncome(token: _user.token!)
        : [];
  }

  Future<String> getOperationNextFolio() async {
    if (_user.token != null) {
      _operationNextFolio = await mbService.getOperationNextFolio(
          token: _user.token!, userEmail: _user.email!);

      return _operationNextFolio;
    } else {
      return "";
    }
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
    if (_user.token != null) {
      final clients = await mbService.getClients(token: _user.token!);

      _clientID = clients.first.id!;
      return clients;
    } else {
      return [];
    }
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
    if (_user.token != null) {
      final companies = await mbService.getCompanies(token: _user.token!);

      _companyId = companies.first.id!;
      return companies;
    } else {
      return [];
    }
  }

  Future<List<Model>> getClientsModels() async {
    _models.clear();
    final List<Model> dbModels = _user.token != null
        ? await mbService.getModel(token: _user.token!)
        : [];

    models.addAll(
        dbModels.map((e) => {"modelId": e.id, "hasIva": false, "value": 0}));

    _modelID = models.first["modelId"];

    return dbModels;
  }

  Future<List<Model>> getPromoterModels() async {
    _modelsPromoters.clear();
    final List<Model> dbModels = _user.token != null
        ? await mbService.getModel(token: _user.token!)
        : [];

    _modelsPromoters.addAll(dbModels.map((e) =>
        {"modelId": e.id, "isPercent": false, "comercialCost": 0, "value": 0}));

    return dbModels;
  }

  Future<List<Model>> getModel() async {
    _operationsModels.clear();
    final List<Model> dbModels = [];
    _user.token != null
        ? dbModels.add(
            await mbService.getModelbyId(token: _user.token!, id: _modelID))
        : [];

    _operationsModels.addAll(dbModels.map((e) => {
          "modelId": e.id,
          "retorno": 0,
          "providerIncomeId": "",
          "providerOutcomeId": ""
        }));

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

  Future<bool> createPromoter() async {
    final Map<String, dynamic> body = {
      "name": _name,
      "userEmail": _user.email,
      "phone": _phone,
      "email": _email,
      "contactByEmail": _contactByEmail,
      "contactByPhone": _contactByPhone,
      "models": _models,
    };

    return mbService.createPromoter(body: body, token: _user.token!);
  }

  Future<bool> createProviderInCome() async {
    final Map<String, dynamic> body = {
      "name": _providerName,
      "invoiceAmount": _costoFactura,
      "noInvoiceAmount": _costoWithoutFactura,
      "invoiceTotal": _providerFactura,
      "noInvoiceTotal": _providerWithOutFactura
    };

    return mbService.createProviderInCome(body: body, token: _user.token!);
  }

  Future<bool> createOperationCalculator() async {
    final Map<String, dynamic> body = {
      "totalOperacion": _totalOperation,
      "isTotalRetorno": true,
      "isComisionCalculator": true,
      "hasInvoice": true,
      "clientsModels": _models,
      "promotersModels": _modelsPromoters,
      "operationsModels": _operationsModels,
    };

    return mbService.createComision(body: body, token: _user.token!);
  }
}
