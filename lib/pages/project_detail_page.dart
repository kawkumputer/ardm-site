import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/project.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrap.dart';
import '../widgets/common.dart';
import '../data/projects_data.dart';

class ProjectDetailPage extends StatelessWidget {
  final String id;
  const ProjectDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Project? project;
    for (final p in projects) {
      if (p.id == id) {
        project = p;
        break;
      }
    }

    if (project == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: ContentWrap(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Projet introuvable', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 14),
              GhostCta(label: 'Retour aux projets', onPressed: () => context.go('/projets')),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: ContentWrap(
        maxWidth: 820,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () => context.go('/projets'),
              icon: const Icon(Icons.arrow_back, size: 18),
              label: const Text('Tous les projets'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: .65),
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 16),
            Text(project.title, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 16),
            if (project.imageAsset != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(project.imageAsset!, height: 320, width: double.infinity, fit: BoxFit.cover),
              ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 1,
              runSpacing: 1,
              children: [
                if (project.budget != null) StatTile(label: 'Budget', value: project.budget!, valueColor: AppColors.bandAccent),
                if (project.deadline != null) StatTile(label: 'Échéance', value: project.deadline!, valueColor: AppColors.bandInk),
                if (project.zone != null) StatTile(label: 'Zone', value: project.zone!, valueColor: AppColors.bandInk),
              ],
            ),
            const SizedBox(height: 28),
            for (final p in project.body)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(p, style: Theme.of(context).textTheme.bodyLarge),
              ),
            if (project.gallery.isNotEmpty) ...[
              const SizedBox(height: 8),
              _GalleryGrid(photos: project.gallery),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 16),
            PrimaryCta(label: 'Soutenir ce projet', onPressed: () => context.go('/soutenir')),
          ],
        ),
      ),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  final List<GalleryPhoto> photos;
  const _GalleryGrid({required this.photos});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 640;
    final captionColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: .65);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: photos.map((photo) {
        return SizedBox(
          width: isWide ? (820 - 32) / 3 : double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(photo.asset, height: 160, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8),
              Text(photo.caption, style: AppTextStyles.mono(size: 12, color: captionColor)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
