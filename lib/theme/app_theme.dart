import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Deux polices : Barlow Condensed pour les titres (affiche/technique),
/// Source Serif 4 pour le texte courant. IBM Plex Mono est utilisé
/// ponctuellement pour les chiffres et libellés (voir [AppTextStyles]).
class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final ink = isDark ? AppColors.inkDark : AppColors.ink;
    final inkSoft = isDark ? AppColors.inkSoftDark : AppColors.inkSoft;
    final paper = isDark ? AppColors.paperDark : AppColors.paper;
    final card = isDark ? AppColors.cardDark : AppColors.card;
    final line = isDark ? AppColors.lineDark : AppColors.line;
    final teal = isDark ? AppColors.tealDark : AppColors.teal;

    final base = GoogleFonts.sourceSerif4TextTheme(
      ThemeData(brightness: brightness).textTheme,
    );

    final display = GoogleFonts.barlowCondensedTextTheme(
      ThemeData(brightness: brightness).textTheme,
    );

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: paper,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: teal,
        onPrimary: isDark ? const Color(0xFF0B1A16) : const Color(0xFFF4FBF9),
        secondary: isDark ? AppColors.goldDark : AppColors.gold,
        onSecondary: isDark ? const Color(0xFF1A1204) : Colors.white,
        error: isDark ? AppColors.redDark : AppColors.red,
        onError: Colors.white,
        surface: card,
        onSurface: ink,
      ),
      textTheme: base.copyWith(
        bodyLarge: base.bodyLarge?.copyWith(color: ink, height: 1.6),
        bodyMedium: base.bodyMedium?.copyWith(color: ink, height: 1.6),
        bodySmall: base.bodySmall?.copyWith(color: inkSoft),
        displayLarge: display.displayLarge?.copyWith(
            color: ink, fontWeight: FontWeight.w700, height: 1.05),
        displayMedium: display.displayMedium?.copyWith(
            color: ink, fontWeight: FontWeight.w700, height: 1.05),
        headlineLarge: display.headlineLarge?.copyWith(
            color: ink, fontWeight: FontWeight.w700, height: 1.08),
        headlineMedium: display.headlineMedium?.copyWith(
            color: ink, fontWeight: FontWeight.w700),
        headlineSmall: display.headlineSmall?.copyWith(
            color: ink, fontWeight: FontWeight.w600),
        titleLarge: display.titleLarge
            ?.copyWith(color: ink, fontWeight: FontWeight.w600),
        titleMedium: display.titleMedium
            ?.copyWith(color: ink, fontWeight: FontWeight.w600),
        labelLarge: display.labelLarge?.copyWith(
            color: ink,
            fontWeight: FontWeight.w600,
            letterSpacing: .4),
      ),
      dividerColor: line,
      cardColor: card,
      appBarTheme: AppBarTheme(
        backgroundColor: paper.withValues(alpha: .92),
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: teal,
          foregroundColor: isDark ? const Color(0xFF0B1A16) : const Color(0xFFF4FBF9),
          textStyle: GoogleFonts.barlowCondensed(
              fontWeight: FontWeight.w600, fontSize: 15.5, letterSpacing: .3),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: teal,
          side: BorderSide(color: teal, width: 1.4),
          textStyle: GoogleFonts.barlowCondensed(
              fontWeight: FontWeight.w600, fontSize: 15, letterSpacing: .3),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: line),
        ),
      ),
      useMaterial3: true,
    );
  }
}

/// Styles ponctuels non couverts par le thème texte (libellés/chiffres en
/// police mono, dans l'esprit des documents de l'association).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle mono({
    double size = 13,
    FontWeight weight = FontWeight.w400,
    Color? color,
  }) =>
      GoogleFonts.ibmPlexMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  static TextStyle eyebrow(Color color) => GoogleFonts.barlowCondensed(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        letterSpacing: 1.4,
        color: color,
      );
}
