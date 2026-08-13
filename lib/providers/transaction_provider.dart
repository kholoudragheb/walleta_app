import 'package:flutter/foundation.dart';
import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final List<TransactionModel> _transactions = [
    TransactionModel(
      id: '1',
      title: 'فطار — فول وطعمية',
      categoryName: 'أكل',
      categoryEmoji: '🍔',
      amount: 40.0,
      date: DateTime.now(),
      timeString: '١٠:٣٠ ص',
      inputMethod: InputMethod.voice,
      originalTranscript: 'صرفت ٤٠ جنيه فطار',
    ),
    TransactionModel(
      id: '2',
      title: 'أوبر — الشغل',
      categoryName: 'مواصلات',
      categoryEmoji: '🚕',
      amount: 65.0,
      date: DateTime.now(),
      timeString: '٨:١٥ ص',
      inputMethod: InputMethod.manual,
    ),
    TransactionModel(
      id: '3',
      title: 'قهوة — كافيه',
      categoryName: 'أكل',
      categoryEmoji: '🍔',
      amount: 75.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
      timeString: '٣:٠٠ م',
      inputMethod: InputMethod.manual,
    ),
    TransactionModel(
      id: '4',
      title: 'اشتراك PlayStation Plus',
      categoryName: 'ترفيه',
      categoryEmoji: '🎮',
      amount: 250.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
      timeString: '١١:٠٠ ص',
      inputMethod: InputMethod.manual,
    ),
    TransactionModel(
      id: '5',
      title: 'سوبر ماركت',
      categoryName: 'تسوق',
      categoryEmoji: '🛒',
      amount: 320.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
      timeString: '٧:٠٠ م',
      inputMethod: InputMethod.manual,
    ),
    TransactionModel(
      id: '6',
      title: 'صيدلية — أدوية',
      categoryName: 'صحة',
      categoryEmoji: '💊',
      amount: 120.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      timeString: '٤:٣٠ م',
      inputMethod: InputMethod.manual,
    ),
    TransactionModel(
      id: '7',
      title: 'شحن موبايل',
      categoryName: 'فواتير',
      categoryEmoji: '📱',
      amount: 100.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      timeString: '١:٠٠ م',
      inputMethod: InputMethod.manual,
    ),
  ];

  String _searchQuery = '';
  String _selectedFilter = 'الكل'; // الكل, اليوم, هذا الأسبوع, هذا الشهر

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  List<TransactionModel> get filteredTransactions {
    return _transactions.where((tx) {
      final matchesSearch = _searchQuery.isEmpty ||
          tx.title.contains(_searchQuery) ||
          tx.categoryName.contains(_searchQuery);
      if (!matchesSearch) return false;

      if (_selectedFilter == 'اليوم') {
        final now = DateTime.now();
        return tx.date.year == now.year &&
            tx.date.month == now.month &&
            tx.date.day == now.day;
      } else if (_selectedFilter == 'هذا الأسبوع') {
        final now = DateTime.now();
        final diff = now.difference(tx.date).inDays;
        return diff <= 7;
      } else if (_selectedFilter == 'هذا الشهر') {
        final now = DateTime.now();
        return tx.date.year == now.year && tx.date.month == now.month;
      }
      return true;
    }).toList();
  }

  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void addTransaction(TransactionModel tx) {
    _transactions.insert(0, tx);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
