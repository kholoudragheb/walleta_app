import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/transaction.dart';
import '../../providers/transaction_provider.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text('تفاصيل المعاملة'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Emoji Circle
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    transaction.categoryEmoji,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                transaction.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '-${transaction.amount.toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 32),

              // Detail Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _DetailRow(label: 'التصنيف', value: '${transaction.categoryEmoji} ${transaction.categoryName}'),
                    const Divider(color: AppColors.border),
                    _DetailRow(label: 'التاريخ', value: '١٥ فبراير ٢٠٢٦'),
                    const Divider(color: AppColors.border),
                    _DetailRow(label: 'الوقت', value: transaction.timeString),
                    const Divider(color: AppColors.border),
                    _DetailRow(
                      label: 'طريقة الإدخال',
                      value: transaction.inputMethod == InputMethod.voice ? '🎤 صوتي' : '✍️ يدوي',
                    ),
                    if (transaction.originalTranscript != null) ...[
                      const Divider(color: AppColors.border),
                      _DetailRow(label: 'النص الأصلي', value: '"${transaction.originalTranscript}"'),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Actions
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  side: const BorderSide(color: AppColors.border),
                ),
                onPressed: () {},
                child: const Text('تعديل', style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  side: BorderSide(color: AppColors.red.withOpacity(0.4)),
                ),
                onPressed: () {
                  context.read<TransactionProvider>().deleteTransaction(transaction.id);
                  Navigator.pop(context);
                },
                child: const Text('حذف', style: TextStyle(color: AppColors.red, fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
