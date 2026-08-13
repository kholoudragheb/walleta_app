import 'package:flutter/material.dart';

class AppColors {
  static const Color bgPrimary = Color(0xFF0A1A16);
  static const Color bgSecondary = Color(0xFF0F2420);
  static const Color bgCard = Color(0xFF132E28);
  static const Color bgCardHover = Color(0xFF1A3D35);
  static const Color bgBody = Color(0xFF050F0D);

  static const Color tealLight = Color(0xFF6EECD4);
  static const Color tealMid = Color(0xFF52D4B8);
  static const Color tealPrimary = Color(0xFF3CB89C);
  static const Color tealDark = Color(0xFF2A9A80);

  static const Color accent = Color(0xFF3CB89C);
  static const Color accentLight = Color(0xFF6EECD4);
  
  static const Color red = Color(0xFFEF4444);
  static const Color orange = Color(0xFFF59E0B);
  static const Color green = Color(0xFF6EECD4);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0x99FFFFFF); // 60%
  static const Color textTertiary = Color(0x59FFFFFF); // 35%

  static const Color border = Color(0x14FFFFFF); // 8%

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [tealLight, tealPrimary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient logoGradient = LinearGradient(
    colors: [tealLight, tealPrimary, tealDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardBgGradient = LinearGradient(
    colors: [Color(0x333CB89C), Color(0x14AB9FF2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
