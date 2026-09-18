import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrap.dart';
import '../widgets/common.dart';
import '../data/association_info.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 720;
    final fiche = _FicheCard();
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SectionHeader(
          eyebrow: 'Qui sommes-nous',
          title: "La diaspora de M'bahé, organisée depuis l'Île-de-France",
        ),
        const SizedBox(height: 16),
        Text(
          "Nous sommes une association loi 1901 réunissant les ressortissants du village de M'bahé "
          "(région du Brakna, Mauritanie) installés en France. Notre mission : mobiliser la solidarité "
          "de la diaspora pour financer des infrastructures utiles au village — en priorité l'accès à "
          "l'éducation et la sécurité des enfants pendant la saison des pluies.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 14),
        Text(
          "Nous travaillons en lien avec les familles restées à M'bahé pour identifier les besoins les "
          "plus urgents, et avec les dispositifs de cofinancement français dédiés aux associations de "
          "diaspora pour les concrétiser.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: ContentWrap(
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: text),
                  const SizedBox(width: 36),
                  Expanded(flex: 2, child: fiche),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [text, const SizedBox(height: 28), fiche],
              ),
      ),
    );
  }
}

class _FicheCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final line = Theme.of(context).dividerColor;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row(context, 'Statut', 'Association loi 1901', line),
            _row(context, 'Depuis', AssociationInfo.since, line),
            _row(context, 'Siège', AssociationInfo.address, line),
            _row(context, 'RNA', AssociationInfo.rna, line),
            _row(context, 'SIRET', AssociationInfo.siret, line),
            _row(context, 'Zone d\'action', AssociationInfo.zone, line),
            _row(context, 'Contact', AssociationInfo.email, line, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value, Color line, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.toUpperCase(), style: AppTextStyles.eyebrow(
                  Theme.of(context).colorScheme.onSurface.withValues(alpha: .6))),
              Flexible(
                child: Text(value,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.mono(size: 13.5)),
              ),
            ],
          ),
          if (!isLast) Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Divider(height: 1, color: line),
          ),
        ],
      ),
    );
  }
}
