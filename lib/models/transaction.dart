enum InputMethod { voice, manual }

class TransactionModel {
  final String id;
  final String title;
  final String categoryName;
  final String categoryEmoji;
  final double amount;
  final DateTime date;
  final String timeString;
  final InputMethod inputMethod;
  final String? originalTranscript;
  final String? notes;

  TransactionModel({
    required this.id,
    required this.title,
    required this.categoryName,
    required this.categoryEmoji,
    required this.amount,
    required this.date,
    required this.timeString,
    this.inputMethod = InputMethod.manual,
    this.originalTranscript,
    this.notes,
  });
}
