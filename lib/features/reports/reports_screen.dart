import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/spending_bar_chart.dart';
import '../../widgets/ai_insight_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _selectedPeriod = 2; // 0: يومي, 1: أسبوعي, 2: شهري

  final List<Map<String, dynamic>> _reportCategories = [
    {'name': 'أكل', 'emoji': '🍔', 'amount': '١,٢٠٠ ج.م', 'pct': 0.75, 'pctText': '٣٢%'},
    {'name': 'مواصلات', 'emoji': '🚕', 'amount': '٨٥٠ ج.م', 'pct': 0.53, 'pctText': '٢٣%'},
    {'name': 'تسوق', 'emoji': '🛒', 'amount': '٦٠٠ ج.م', 'pct': 0.38, 'pctText': '١٦%'},
    {'name': 'ترفيه', 'emoji': '🎮', 'amount': '٥٠٠ ج.م', 'pct': 0.31, 'pctText': '١٣%'},
    {'name': 'صحة', 'emoji': '💊', 'amount': '٣٥٠ ج.م', 'pct': 0.22, 'pctText': '٩%'},
  ];

  @override
  Widget build(BuildContext context) {
    final periods = ['يومي', 'أسبوعي', 'شهري'];

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text('التقارير'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Period Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  periods.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedPeriod = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedPeriod == index ? AppColors.tealPrimary : AppColors.bgCard,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        periods[index],
                        style: TextStyle(
                          color: _selectedPeriod == index ? Colors.white : AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: _selectedPeriod == index ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Total Spending Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const Text(
                      'إجمالي الصرف — فبراير',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '٣,٧٥٠ ج.م',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('↑ ١٢%', style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        SizedBox(width: 4),
                        Text('أكتر من يناير', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bar Chart Widget
              const SpendingBarChart(),

              const SizedBox(height: 24),

              // Categories Breakdown
              const Text(
                'التصنيفات',
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Column(
                children: _reportCategories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(cat['emoji'], style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cat['name'], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                  Text(cat['amount'], style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: cat['pct'],
                                  minHeight: 6,
                                  backgroundColor: Colors.white.withOpacity(0.08),
                                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.tealLight),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(cat['pctText'], style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // AI Insight Card Widget
              const AIInsightCard(),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
