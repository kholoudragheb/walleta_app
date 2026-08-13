import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final double remainingAmount;
  final double spentAmount;
  final double totalBudget;
  final VoidCallback onBudgetTap;
  final VoidCallback onAddExpenseTap;
  final VoidCallback onReportsTap;

  const BalanceCard({
    super.key,
    required this.remainingAmount,
    required this.spentAmount,
    required this.totalBudget,
    required this.onBudgetTap,
    required this.onAddExpenseTap,
    required this.onReportsTap,
  });

  String _formatNumber(double val) {
    return val.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final double pct = totalBudget > 0 ? (spentAmount / totalBudget).clamp(0.0, 1.0) : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.tealPrimary.withOpacity(0.3)),
        gradient: AppColors.cardBgGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.tealPrimary.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tealPrimary.withOpacity(0.15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الميزانية المتبقية',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _formatNumber(remainingAmount),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'ج.م',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.08),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.tealLight),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'صرفت ${_formatNumber(spentAmount)} ج.م',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'من ${_formatNumber(totalBudget)} ج.م',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.white.withOpacity(0.06), height: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ActionButton(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'ميزانية',
                      onTap: onBudgetTap,
                    ),
                    _ActionButton(
                      icon: Icons.add,
                      label: 'أضف مصروف',
                      isHighlight: true,
                      onTap: onAddExpenseTap,
                    ),
                    _ActionButton(
                      icon: Icons.bar_chart_outlined,
                      label: 'تقارير',
                      onTap: onReportsTap,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isHighlight;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.isHighlight = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: isHighlight ? AppColors.primaryGradient : null,
              color: isHighlight ? null : Colors.white.withOpacity(0.06),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
