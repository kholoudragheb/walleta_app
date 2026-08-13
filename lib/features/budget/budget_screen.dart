import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/budget_provider.dart';
import '../../widgets/circular_gauge.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = context.read<BudgetProvider>().monthlyBudget;
  }

  @override
  Widget build(BuildContext context) {
    final budgetProv = context.watch<BudgetProvider>();

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text('الميزانية'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Circular Gauge
              CircularGauge(percentage: budgetProv.percentage),

              const SizedBox(height: 24),

              // Stats Cards
              Row(
                children: [
                  _StatCard(title: 'الميزانية الشهرية', value: '${budgetProv.monthlyBudget.toStringAsFixed(0)} ج.م'),
                  const SizedBox(width: 8),
                  _StatCard(title: 'تم صرفه', value: '${budgetProv.totalSpent.toStringAsFixed(0)} ج.م', color: AppColors.red),
                  const SizedBox(width: 8),
                  _StatCard(title: 'المتبقي', value: '${budgetProv.remaining.toStringAsFixed(0)} ج.م', color: AppColors.tealLight),
                ],
              ),

              const SizedBox(height: 28),

              // Monthly Budget Slider
              Align(
                alignment: Alignment.centerRight,
                child: const Text('تعديل الميزانية الشهرية', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.tealLight,
                  inactiveTrackColor: Colors.white.withOpacity(0.1),
                  thumbColor: AppColors.tealLight,
                ),
                child: Slider(
                  min: 1000,
                  max: 50000,
                  divisions: 98,
                  value: _sliderValue,
                  onChanged: (val) => setState(() => _sliderValue = val),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('١,٠٠٠', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  Text('${_sliderValue.toStringAsFixed(0)} ج.م', style: const TextStyle(color: AppColors.tealLight, fontWeight: FontWeight.bold, fontSize: 14)),
                  const Text('٥٠,٠٠٠', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),

              const SizedBox(height: 28),

              // Category Budgets List
              Align(
                alignment: Alignment.centerRight,
                child: const Text('ميزانية التصنيفات', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),

              Column(
                children: budgetProv.categories.map((cat) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.bgCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Text(cat.emoji, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(cat.name, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        Text('${cat.budgetLimit.toStringAsFixed(0)} ج.م', style: const TextStyle(color: AppColors.tealLight, fontSize: 13)),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    budgetProv.updateMonthlyBudget(_sliderValue);
                    Navigator.pop(context);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'حفظ التعديلات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({required this.title, required this.value, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11), maxLines: 1),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
