import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../data/association_info.dart';
import 'content_wrap.dart';

const _navItems = [
  (label: 'Accueil', path: '/'),
  (label: 'Association', path: '/association'),
  (label: 'Nos projets', path: '/projets'),
  (label: 'Nous soutenir', path: '/soutenir'),
  (label: 'Contact', path: '/contact'),
];

const double kWideBreakpoint = 760;

/// Ossature commune à toutes les pages : navigation en haut (barre sur
/// grand écran, menu tiroir sur mobile), contenu, puis pied de page.
class SiteShell extends StatelessWidget {
  final Widget child;
  final String location;

  const SiteShell({super.key, required this.child, required this.location});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= kWideBreakpoint;
    final ink = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      endDrawer: isWide ? null : _MobileMenu(location: location),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _NavBar(isWide: isWide, location: location, ink: ink)),
          SliverToBoxAdapter(child: child),
          SliverToBoxAdapter(child: _Footer(ink: ink)),
        ],
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final bool isWide;
  final String location;
  final Color ink;

  const _NavBar({required this.isWide, required this.location, required this.ink});

  @override
  Widget build(BuildContext context) {
    final line = Theme.of(context).dividerColor;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(bottom: BorderSide(color: line)),
      ),
      child: ContentWrap(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            _Brand(ink: ink),
            const Spacer(),
            if (isWide)
              Row(
                children: _navItems.map((item) {
                  final active = location == item.path;
                  return Padding(
                    padding: const EdgeInsets.only(left: 26),
                    child: InkWell(
                      onTap: () => context.go(item.path),
                      child: Text(
                        item.label,
                        style: AppTextStyles.eyebrow(
                          active ? AppColors.teal : ink.withValues(alpha: .68),
                        ).copyWith(fontSize: 15, letterSpacing: .3),
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  final Color ink;
  const _Brand({required this.ink});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AssociationInfo.brandShort,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 19, color: ink)),
          Text(AssociationInfo.brandTagline.toUpperCase(),
              style: AppTextStyles.mono(size: 10, color: ink.withValues(alpha: .6))
                  .copyWith(letterSpacing: .8)),
        ],
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final String location;
  const _MobileMenu({required this.location});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: _navItems.map((item) {
            final active = location == item.path;
            return ListTile(
              title: Text(item.label,
                  style: AppTextStyles.eyebrow(
                    active
                        ? AppColors.teal
                        : Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontSize: 16)),
              onTap: () {
                Navigator.of(context).pop();
                context.go(item.path);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final Color ink;
  const _Footer({required this.ink});

  @override
  Widget build(BuildContext context) {
    final inkSoft = ink.withValues(alpha: .62);
    final line = Theme.of(context).dividerColor;
    final isWide = MediaQuery.of(context).size.width >= kWideBreakpoint;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: line)),
      ),
      child: ContentWrap(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment:
                  isWide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text(AssociationInfo.brandShort,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: ink)),
                if (isWide) const Spacer() else const SizedBox(height: 10),
                Text(AssociationInfo.email, style: AppTextStyles.mono(size: 12.5, color: inkSoft)),
                const SizedBox(width: 16, height: 4),
                Text(AssociationInfo.phone, style: AppTextStyles.mono(size: 12.5, color: inkSoft)),
                const SizedBox(width: 16, height: 4),
                Text(AssociationInfo.address, style: AppTextStyles.mono(size: 12.5, color: inkSoft)),
              ],
            ),
            const SizedBox(height: 14),
            Divider(color: line),
            const SizedBox(height: 10),
            Text(
              '${AssociationInfo.legalName} · RNA ${AssociationInfo.rna} · SIRET ${AssociationInfo.siret} '
              '· Zone d\'action : ${AssociationInfo.zone}',
              style: TextStyle(fontSize: 12.5, color: inkSoft),
            ),
          ],
        ),
      ),
    );
  }
}
