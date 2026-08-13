import 'package:flutter/foundation.dart';
import '../models/category.dart';

class BudgetProvider extends ChangeNotifier {
  double _monthlyBudget = 7000.0;
  double _totalSpent = 3750.0;

  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'أكل', emoji: '🍔', spentAmount: 1200, budgetLimit: 2000),
    CategoryModel(id: '2', name: 'مواصلات', emoji: '🚕', spentAmount: 850, budgetLimit: 1500),
    CategoryModel(id: '3', name: 'ترفيه', emoji: '🎮', spentAmount: 500, budgetLimit: 1000),
    CategoryModel(id: '4', name: 'صحة', emoji: '💊', spentAmount: 350, budgetLimit: 500),
    CategoryModel(id: '5', name: 'تسوق', emoji: '🛒', spentAmount: 600, budgetLimit: 1500),
    CategoryModel(id: '6', name: 'فواتير', emoji: '📱', spentAmount: 250, budgetLimit: 750),
    CategoryModel(id: '7', name: 'تعليم', emoji: '📚', spentAmount: 0, budgetLimit: 500),
  ];

  double get monthlyBudget => _monthlyBudget;
  double get totalSpent => _totalSpent;
  double get remaining => (_monthlyBudget - _totalSpent).clamp(0.0, double.infinity);
  double get percentage => _monthlyBudget > 0 ? (_totalSpent / _monthlyBudget).clamp(0.0, 1.0) : 0.0;

  List<CategoryModel> get categories => List.unmodifiable(_categories);

  void updateMonthlyBudget(double newBudget) {
    _monthlyBudget = newBudget;
    notifyListeners();
  }

  void addExpense(double amount, String categoryName) {
    _totalSpent += amount;
    final index = _categories.indexWhere((c) => c.name == categoryName);
    if (index != -1) {
      final old = _categories[index];
      _categories[index] = CategoryModel(
        id: old.id,
        name: old.name,
        emoji: old.emoji,
        spentAmount: old.spentAmount + amount,
        budgetLimit: old.budgetLimit,
      );
    }
    notifyListeners();
  }
}
