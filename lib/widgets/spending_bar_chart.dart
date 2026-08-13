import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class SpendingBarChart extends StatelessWidget {
  const SpendingBarChart({super.key});

  static const List<Map<String, dynamic>> _data = [
    {'day': 'سبت', 'pct': 0.40, 'active': false},
    {'day': 'حد', 'pct': 0.65, 'active': false},
    {'day': 'اتنين', 'pct': 0.30, 'active': false},
    {'day': 'تلات', 'pct': 0.80, 'active': false},
    {'day': 'أربع', 'pct': 0.55, 'active': false},
    {'day': 'خميس', 'pct': 0.90, 'active': true},
    {'day': 'جمعة', 'pct': 0.45, 'active': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: SizedBox(
        height: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _data.map((item) {
            final bool isActive = item['active'];
            final double pct = item['pct'];
            final String day = item['day'];

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 14,
                      height: 120 * pct,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: isActive
                            ? AppColors.primaryGradient
                            : null,
                        color: isActive
                            ? null
                            : Colors.white.withOpacity(0.12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  day,
                  style: TextStyle(
                    color: isActive ? AppColors.tealLight : AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
