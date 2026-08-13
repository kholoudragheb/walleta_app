import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/transaction.dart';
import '../../providers/voice_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/budget_provider.dart';
import 'voice_success_screen.dart';

class VoiceScreen extends StatelessWidget {
  const VoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final voiceProv = context.watch<VoiceProvider>();

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text('تسجيل بالصوت'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            voiceProv.resetVoice();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (voiceProv.state == VoiceState.idle) ...[
                const Text(
                  'اضغط على المايك وقول مصروفك',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'مثال: "صرفت ٤٠ جنيه فطار"',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 48),
                _VoiceRingsWidget(isRecording: false, onTap: voiceProv.toggleVoice),
              ] else if (voiceProv.state == VoiceState.listening) ...[
                const Text(
                  'بسمعك... 🎙️',
                  style: TextStyle(
                    color: AppColors.tealLight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'اتكلم دلوقتي',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 48),
                _VoiceRingsWidget(isRecording: true, onTap: voiceProv.toggleVoice),
              ] else if (voiceProv.state == VoiceState.analyzing) ...[
                const Text(
                  'بحلل كلامك... ⏳',
                  style: TextStyle(
                    color: AppColors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
                const CircularProgressIndicator(color: AppColors.tealLight),
              ] else if (voiceProv.state == VoiceState.parsed) ...[
                // Voice Result Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'كلامك:',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '"${voiceProv.detectedText}"',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.bgSecondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _ParsedRow(label: 'المبلغ', value: '${voiceProv.parsedAmount.toStringAsFixed(0)} ج.م'),
                      const Divider(color: AppColors.border),
                      _ParsedRow(label: 'الوصف', value: voiceProv.parsedDescription),
                      const Divider(color: AppColors.border),
                      _ParsedRow(
                        label: 'التصنيف',
                        customValue: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.tealPrimary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${voiceProv.parsedCategoryEmoji} ${voiceProv.parsedCategory}'),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.tealLight,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'AI',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      final newTx = TransactionModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: voiceProv.parsedDescription,
                        categoryName: voiceProv.parsedCategory,
                        categoryEmoji: voiceProv.parsedCategoryEmoji,
                        amount: voiceProv.parsedAmount,
                        date: DateTime.now(),
                        timeString: 'الآن',
                        inputMethod: InputMethod.voice,
                        originalTranscript: voiceProv.detectedText,
                      );
                      context.read<TransactionProvider>().addTransaction(newTx);
                      context.read<BudgetProvider>().addExpense(voiceProv.parsedAmount, voiceProv.parsedCategory);
                      voiceProv.resetVoice();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VoiceSuccessScreen(
                            title: voiceProv.parsedDescription,
                            amount: voiceProv.parsedAmount,
                            category: voiceProv.parsedCategory,
                          ),
                        ),
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'تأكيد ✓',
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
                const SizedBox(height: 12),
                TextButton(
                  onPressed: voiceProv.resetVoice,
                  child: const Text(
                    'إعادة التسجيل',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _VoiceRingsWidget extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onTap;

  const _VoiceRingsWidget({required this.isRecording, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isRecording
                    ? AppColors.red.withOpacity(0.3)
                    : AppColors.tealPrimary.withOpacity(0.1),
                width: 2,
              ),
            ),
          ),
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isRecording
                    ? AppColors.red.withOpacity(0.5)
                    : AppColors.tealPrimary.withOpacity(0.2),
                width: 2,
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isRecording
                  ? const LinearGradient(colors: [Color(0xFFFF6B6B), AppColors.red])
                  : AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: (isRecording ? AppColors.red : AppColors.tealPrimary).withOpacity(0.4),
                  blurRadius: 32,
                  spreadRadius: 4,
                )
              ],
            ),
            child: const Center(
              child: Icon(Icons.mic_rounded, color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParsedRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? customValue;

  const _ParsedRow({required this.label, this.value, this.customValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          if (customValue != null)
            customValue!
          else
            Text(value!, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
