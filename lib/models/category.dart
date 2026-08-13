class CategoryModel {
  final String id;
  final String name;
  final String emoji;
  final double spentAmount;
  final double budgetLimit;

  CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.spentAmount,
    required this.budgetLimit,
  });

  double get percentage => budgetLimit > 0 ? (spentAmount / budgetLimit).clamp(0.0, 1.0) : 0.0;
}
