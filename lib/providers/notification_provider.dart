import 'package:flutter/foundation.dart';
import '../models/notification_item.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationItemModel> _notifications = [
    NotificationItemModel(
      id: '1',
      icon: '⚠️',
      title: 'ميزانية الأكل وصلت ٦٠%',
      description: 'صرفت ١,٢٠٠ من ٢,٠٠٠ ج.م المخصصة للأكل',
      timeAgo: 'من ٥ دقايق',
      isUnread: true,
    ),
    NotificationItemModel(
      id: '2',
      icon: '🤖',
      title: 'تصنيف جديد تم إنشاؤه',
      description: 'Walleta أنشأ تصنيف "صحة" بناءً على مصاريفك',
      timeAgo: 'من ساعة',
      isUnread: true,
    ),
    NotificationItemModel(
      id: '3',
      icon: '📊',
      title: 'تقرير الأسبوع جاهز',
      description: 'شوف ملخص مصاريفك للأسبوع اللي فات',
      timeAgo: 'من ٣ ساعات',
      isUnread: true,
    ),
    NotificationItemModel(
      id: '4',
      icon: '✅',
      title: 'تم تسجيل مصروف بنجاح',
      description: 'أوبر — ٦٥ ج.م تم إضافته في مواصلات',
      timeAgo: 'إمبارح',
      isUnread: false,
    ),
    NotificationItemModel(
      id: '5',
      icon: '💡',
      title: 'نصيحة: وفّر في المواصلات',
      description: 'جرب المواصلات العامة مرتين في الأسبوع وهتوفر ~٣٠٠ ج.م شهرياً',
      timeAgo: 'من يومين',
      isUnread: false,
    ),
  ];

  List<NotificationItemModel> get notifications => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => n.isUnread).length;

  void markAllAsRead() {
    for (var n in _notifications) {
      n.isUnread = false;
    }
    notifyListeners();
  }
}
