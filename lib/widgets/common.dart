import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final Color? color;

  const SectionHeader({super.key, required this.eyebrow, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    final ink = color ?? Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(eyebrow.toUpperCase(), style: AppTextStyles.eyebrow(AppColors.teal)),
        const SizedBox(height: 8),
        Text(title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: ink,
                  fontSize: MediaQuery.of(context).size.width < 600 ? 28 : 34,
                )),
      ],
    );
  }
}

class UrgenceCallout extends StatelessWidget {
  final String text;
  const UrgenceCallout({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final red = isDark ? AppColors.redDark : AppColors.red;
    final redSoft = isDark ? AppColors.redSoftDark : AppColors.redSoft;
    final line = Theme.of(context).dividerColor;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: redSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.alphaBlend(red.withValues(alpha: .35), line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('URGENCE', style: AppTextStyles.eyebrow(red)),
          const SizedBox(width: 14),
          Expanded(
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontStyle: FontStyle.normal)),
          ),
        ],
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? borderColor;
  const Tag({super.key, required this.label, this.color, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor ?? AppColors.bandLine),
      ),
      child: Text(label,
          style: AppTextStyles.eyebrow(color ?? AppColors.bandInkSoft)
              .copyWith(fontSize: 13.5)),
    );
  }
}

class StatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const StatTile({super.key, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      color: Color.alphaBlend(Colors.black.withValues(alpha: .06), AppColors.bandBg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.toUpperCase(),
              style: AppTextStyles.eyebrow(AppColors.bandInkSoft).copyWith(letterSpacing: .8)),
          const SizedBox(height: 6),
          Text(value,
              style: AppTextStyles.mono(
                  size: 19, weight: FontWeight.w600, color: valueColor ?? AppColors.bandInk)),
        ],
      ),
    );
  }
}

class PrimaryCta extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const PrimaryCta({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) => FilledButton(onPressed: onPressed, child: Text(label));
}

class GhostCta extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const GhostCta({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) => OutlinedButton(onPressed: onPressed, child: Text(label));
}
