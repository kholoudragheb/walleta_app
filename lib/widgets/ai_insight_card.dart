import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AIInsightCard extends StatelessWidget {
  final String text;

  const AIInsightCard({
    super.key,
    this.text = 'صرفك على الأكل زاد ٢٠% عن الشهر اللي فات. حاول تقلل الأكل بره وتطبخ في البيت أكتر 🍳',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.tealPrimary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('🤖', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                'نصيحة Walleta',
                style: TextStyle(
                  color: AppColors.tealLight,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
