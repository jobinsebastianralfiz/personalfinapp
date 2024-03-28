import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personalfinanceapp/models/income_model.dart';

import '../models/expense_model.dart';

class UserServvice with ChangeNotifier {
  static const String _incomeBoxName = 'incomes';
  static const String _expenseBoxName = 'expenses';

  double _totalIncome = 0.0;
  double _totalExpense = 0.0;

  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;


  Future<void> calculateTotalIncomeForUser(String userId) async {
    await _calculateTotalIncome(userId);
    notifyListeners();
  }
  Future<void> calculateTotalExpenseForUser(String userId) async {
    await _calculateTotalExpense(userId);
    notifyListeners();
  }

  // open box

  Future<Box<IncomeModel>> openIncomeBox() async {
    return await Hive.openBox<IncomeModel>(_incomeBoxName);
  }

  Future<Box<ExpenseModel>> openExpenseBox() async {
    return await Hive.openBox<ExpenseModel>(_expenseBoxName);
  }

  Future<void> addIncome(IncomeModel income) async {
    final incomeBox = await openIncomeBox();

    await incomeBox.add(income);

    await _calculateTotalIncome(income.uid);
    notifyListeners();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    final expenseBox = await openExpenseBox();

    await expenseBox.add(expense);
    await _calculateTotalExpense(expense.uid);
    notifyListeners();
  }

  Future<void> _calculateTotalIncome(String uid) async {
    final List<IncomeModel> incomes = await getAllIncome(uid);

    _totalIncome = incomes.fold(
        0.0, (previousValue, income) => previousValue + income.amount);

  notifyListeners();
  }

  Future<void> _calculateTotalExpense(String uid) async {
    final List<ExpenseModel> expenses = await getAllExpense(uid);

    _totalExpense = expenses.fold(
        0.0, (previousValue, expense) => previousValue + expense.amount);

 notifyListeners();
  }

  Future<List<IncomeModel>> getAllIncome(String uid) async {
    final incomeBox = await openIncomeBox();
    return incomeBox.values.where((income) => income.uid == uid).toList();
  }

  Future<List<ExpenseModel>> getAllExpense(String uid) async {
    final expenseBox = await openExpenseBox();
    return expenseBox.values.where((expense) => expense.uid == uid).toList();
  }
}
