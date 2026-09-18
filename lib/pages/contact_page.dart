import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrap.dart';
import '../widgets/common.dart';
import '../data/association_info.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: ContentWrap(
        maxWidth: 720,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(eyebrow: 'Contact', title: 'Parlons de votre soutien au projet'),
            const SizedBox(height: 20),
            Text(
              "Bailleur institutionnel, fondation, entreprise, collectivité intéressée par un jumelage, "
              "ou membre de la diaspora : écrivez-nous, nous revenons vers vous rapidement.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ContactRow(icon: Icons.mail_outline, label: 'Email', value: AssociationInfo.email),
                    const SizedBox(height: 14),
                    _ContactRow(icon: Icons.call_outlined, label: 'Téléphone', value: AssociationInfo.phone),
                    const SizedBox(height: 14),
                    _ContactRow(icon: Icons.place_outlined, label: 'Adresse', value: AssociationInfo.address),
                    const SizedBox(height: 22),
                    PrimaryCta(
                      label: "Écrire un e-mail",
                      onPressed: () => _sendMail(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: AssociationInfo.email,
      query: 'subject=${Uri.encodeComponent("Soutien au projet M'bahé")}',
    );
    await launchUrl(uri);
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: color.withValues(alpha: .6)),
        const SizedBox(width: 12),
        Text(label.toUpperCase(), style: AppTextStyles.eyebrow(color.withValues(alpha: .55))),
        const SizedBox(width: 12),
        Expanded(child: Text(value, style: AppTextStyles.mono(size: 14.5))),
      ],
    );
  }
}
