class NotificationItemModel {
  final String id;
  final String icon;
  final String title;
  final String description;
  final String timeAgo;
  bool isUnread;

  NotificationItemModel({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.timeAgo,
    this.isUnread = false,
  });
}
