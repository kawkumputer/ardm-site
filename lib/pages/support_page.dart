import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/content_wrap.dart';
import '../widgets/common.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 820;
    final cards = [
      _SupportCard(
        title: 'Faire un don',
        text: "Chaque contribution, quel que soit son montant, rapproche le projet de son financement. "
            "Une campagne de collecte est en préparation.",
        cta: "Être informé du lancement",
      ),
      _SupportCard(
        title: 'Devenir partenaire',
        text: "Fondation, entreprise ou institution : nous recherchons des cofinancements complémentaires "
            "pour boucler le budget avant l'échéance de chantier.",
        cta: "Nous contacter",
      ),
      _SupportCard(
        title: 'Un jumelage',
        text: "Collectivité française déjà engagée en coopération avec la Mauritanie, ou souhaitant le "
            "devenir : parlons d'un partenariat durable avec M'bahé.",
        cta: "Échanger avec nous",
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: ContentWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(eyebrow: 'Nous soutenir', title: 'Trois façons de contribuer'),
            const SizedBox(height: 30),
            isWide
                ? IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: cards
                          .map((c) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 16), child: c)))
                          .toList(),
                    ),
                  )
                : Column(
                    children: cards.map((c) => Padding(padding: const EdgeInsets.only(bottom: 16), child: c)).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final String title;
  final String text;
  final String cta;
  const _SupportCard({required this.title, required this.text, required this.cta});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(text, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 14),
            GhostCta(label: cta, onPressed: () => context.go('/contact')),
          ],
        ),
      ),
    );
  }
}
