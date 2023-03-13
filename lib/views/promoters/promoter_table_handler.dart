import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;

class PromoterDataNotifier with ChangeNotifier {
  // List<UserModel> get userModel => _userModel;

  // SORT COLUMN INDEX...
  int? get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int? sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....
  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  // -------------------------------------- INTERNALS --------------------------------------------

  int? _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
}
