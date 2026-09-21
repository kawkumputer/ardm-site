import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/project.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrap.dart';
import '../widgets/common.dart';
import '../data/projects_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final flagship = projects.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Hero(photos: flagship.gallery),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 56),
          child: ContentWrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  eyebrow: 'Qui sommes-nous',
                  title: 'La diaspora de M\'bahé, organisée depuis la France',
                ),
                const SizedBox(height: 16),
                Text(
                  "Nous sommes une association loi 1901 réunissant les ressortissants du village de M'bahé "
                  "(région du Brakna, Mauritanie) installés en France. Notre mission : mobiliser la solidarité "
                  "de la diaspora pour financer des infrastructures utiles au village.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 18),
                GhostCta(label: 'En savoir plus sur l\'association', onPressed: () => context.go('/association')),
              ],
            ),
          ),
        ),
        const _StatsBand(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 56),
          child: ContentWrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(eyebrow: 'À l\'affiche', title: 'Le projet en cours'),
                const SizedBox(height: 20),
                _FlagshipCard(project: flagship),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Hero extends StatefulWidget {
  final List<GalleryPhoto> photos;
  const _Hero({required this.photos});

  @override
  State<_Hero> createState() => _HeroState();
}

class _HeroState extends State<_Hero> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (widget.photos.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted) return;
        _index = (_index + 1) % widget.photos.length;
        _controller.animateToPage(
          _index,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = (width * 0.62).clamp(380.0, 620.0);
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.photos.isNotEmpty)
            PageView.builder(
              controller: _controller,
              itemCount: widget.photos.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) {
                final photo = widget.photos[i];
                return Image.asset(photo.asset, fit: BoxFit.cover, alignment: photo.alignment);
              },
            ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: .15),
                  Colors.black.withValues(alpha: .35),
                  Colors.black.withValues(alpha: .88),
                ],
                stops: const [0, .45, 1],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ContentWrap(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("MAURITANIE · BRAKNA · M'BAHÉ",
                        style: AppTextStyles.mono(size: 12, color: const Color(0xFFB9CCC3))
                            .copyWith(letterSpacing: 1)),
                    const SizedBox(height: 12),
                    Text(
                      "Une école pour tous les enfants de M'bahé, toute l'année.",
                      style: TextStyle(
                        fontFamily: Theme.of(context).textTheme.headlineLarge?.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: width < 600 ? 32 : 48,
                        height: 1.05,
                        color: const Color(0xFFF4FBF9),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 620),
                      child: Text(
                        "Un marigot coupe notre village en deux. Chaque saison des pluies, les enfants de "
                        "l'autre rive traversent en pirogue pour aller en classe. Nous construisons une "
                        "deuxième école pour que cela cesse.",
                        style: TextStyle(
                          fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
                          fontStyle: FontStyle.italic,
                          fontSize: width < 600 ? 15 : 18,
                          color: const Color(0xFFDCE7E1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        PrimaryCta(label: 'Découvrir le projet', onPressed: () => context.go('/projets')),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFF4FBF9),
                            side: const BorderSide(color: Color(0x8CF4FBF9)),
                          ),
                          onPressed: () => context.go('/contact'),
                          child: const Text('Nous contacter'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.photos.length > 1)
            Positioned(
              right: 20,
              bottom: 18,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.photos.length, (i) {
                  final active = i == _index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(left: 6),
                    width: active ? 18 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: active ? .95 : .45),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatsBand extends StatelessWidget {
  const _StatsBand();

  @override
  Widget build(BuildContext context) {
    final flagship = projects.first;
    return ColoredBox(
      color: AppColors.bandBg,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 52),
        child: ContentWrap(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('EN CHIFFRES', style: AppTextStyles.eyebrow(AppColors.bandAccent)),
              const SizedBox(height: 8),
              Text('Ce que représente le projet en cours',
                  style: TextStyle(
                      fontFamily: Theme.of(context).textTheme.headlineLarge?.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: AppColors.bandInk)),
              const SizedBox(height: 26),
              Wrap(
                spacing: 1,
                runSpacing: 1,
                children: [
                  StatTile(label: 'Budget total', value: flagship.budget ?? '—'),
                  StatTile(label: 'Échéance chantier', value: flagship.deadline ?? '—'),
                  StatTile(label: 'Zone', value: flagship.zone ?? '—'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlagshipCard extends StatelessWidget {
  final dynamic project;
  const _FlagshipCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 720;
    final image = project.imageAsset != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(project.imageAsset, height: 220, width: double.infinity, fit: BoxFit.cover, alignment: Alignment.topCenter),
          )
        : const SizedBox.shrink();

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        Text(project.shortDescription, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        GhostCta(
          label: 'Voir le projet',
          onPressed: () => context.go('/projets/${project.id}'),
        ),
      ],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: image),
                  const SizedBox(width: 24),
                  Expanded(child: text),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [image, const SizedBox(height: 18), text],
              ),
      ),
    );
  }
}
