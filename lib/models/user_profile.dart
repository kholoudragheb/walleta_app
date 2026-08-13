class UserProfileModel {
  final String name;
  final String email;
  final String avatarLetter;
  final String currency;
  final String language;
  final String theme;

  UserProfileModel({
    required this.name,
    required this.email,
    required this.avatarLetter,
    this.currency = 'ج.م (EGP)',
    this.language = 'العربية',
    this.theme = 'داكن',
  });
}
