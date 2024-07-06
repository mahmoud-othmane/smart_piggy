import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/piggy_model.dart';

class HomeProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  double? _totalExpenses;
  double? _totalIncome;

  double get totalExpenses => _totalExpenses ?? 0.0;

  double get totalIncome => _totalIncome ?? 0.0;

  Future<void> addToPiggy(PiggyModel piggy) async {
    await _saveToLocal(piggy);
    notifyListeners();
  }

  Future<void> _saveToLocal(PiggyModel piggy) async {
    List<PiggyModel> tempPiggies = [...await getAllData(), piggy];
    final jsonList = PiggyModel.toJsonList(tempPiggies);
    _updateIncomeExpenses(tempPiggies);
    String? piggiesJsonString = json.encode(jsonList);
    await storage.write(key: 'piggies', value: piggiesJsonString);
  }

  void _updateIncomeExpenses(List<PiggyModel> models) {
    _totalExpenses = 0;
    _totalIncome = 0;
    final totalExpensesList =
        models.where((model) => model.sign == "-").toList();
    for (final expense in totalExpensesList) {
      _totalExpenses ??= 0.0;
      _totalExpenses = _totalExpenses! + expense.amount;
    }
    final totalIncomeList = models.where((model) => model.sign == "+").toList();
    for (final expense in totalIncomeList) {
      _totalIncome ??= 0.0;
      _totalIncome = _totalIncome! + expense.amount;
    }
  }

  Future<List<PiggyModel>> getAllData() async {
    final exist = await storage.containsKey(key: 'piggies');
    if (!exist) {
      _totalExpenses = 0.0;
      _totalIncome = 0.0;
      return <PiggyModel>[];
    }
    List jsonString = json.decode((await storage.read(key: 'piggies')) ?? '');
    final list = PiggyModel.fromJsonList(jsonString);
    _updateIncomeExpenses(list);
    return list;
  }

  Future<void> clearPiggies() async {
    await storage.deleteAll();
    _totalExpenses = 0.0;
    _totalIncome = 0.0;
    notifyListeners();
  }
}
