import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../budget/budget_screen.dart';
import '../categories/categories_screen.dart';
import '../notifications/notifications_screen.dart';
import '../splash/splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text('حسابي'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Avatar & User Info
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
                child: const Center(
                  child: Text(
                    'و',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'ويلو',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'welo@email.com',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 32),

              // Settings List
              Container(
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: '💰',
                      title: 'الميزانية',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const BudgetScreen()));
                      },
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    _SettingsTile(
                      icon: '📂',
                      title: 'التصنيفات',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen()));
                      },
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    _SettingsTile(
                      icon: '🔔',
                      title: 'الإشعارات',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                      },
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    const _SettingsTile(icon: '🌙', title: 'المظهر', value: 'داكن'),
                    const Divider(color: AppColors.border, height: 1),
                    const _SettingsTile(icon: '🌍', title: 'اللغة', value: 'العربية'),
                    const Divider(color: AppColors.border, height: 1),
                    const _SettingsTile(icon: '💳', title: 'العملة', value: 'ج.م (EGP)'),
                    const Divider(color: AppColors.border, height: 1),
                    const _SettingsTile(icon: '📤', title: 'تصدير البيانات'),
                    const Divider(color: AppColors.border, height: 1),
                    const _SettingsTile(icon: '❓', title: 'المساعدة'),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Logout Button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  side: BorderSide(color: AppColors.red.withOpacity(0.4)),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()),
                    (route) => false,
                  );
                },
                child: const Text('تسجيل الخروج', style: TextStyle(color: AppColors.red, fontSize: 15, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 16),
              const Text('Walleta v1.0.0', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String icon;
  final String title;
  final String? value;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            if (value != null)
              Text(value!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))
            else
              const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textTertiary, size: 16),
          ],
        ),
      ),
    );
  }
}
