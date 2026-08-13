class BudgetModel {
  final double totalBudget;
  final double totalSpent;

  BudgetModel({
    required this.totalBudget,
    required this.totalSpent,
  });

  double get remaining => (totalBudget - totalSpent).clamp(0.0, double.infinity);
  double get percentage => totalBudget > 0 ? (totalSpent / totalBudget).clamp(0.0, 1.0) : 0.0;
}
