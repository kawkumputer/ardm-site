import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/project.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/content_wrap.dart';
import '../widgets/common.dart';
import '../data/projects_data.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: ContentWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Nos projets',
              title: 'Ce que l\'association compte réaliser à M\'bahé',
            ),
            const SizedBox(height: 30),
            ...projects.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _ProjectRow(project: p),
                )),
          ],
        ),
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final Project project;
  const _ProjectRow({required this.project});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 640;
    final image = project.imageAsset != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(project.imageAsset!, height: 190, width: double.infinity, fit: BoxFit.cover, alignment: Alignment.topCenter),
          )
        : Container(
            height: 190,
            decoration: BoxDecoration(
              color: AppColors.tealSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.image_outlined, color: AppColors.teal.withValues(alpha: .5), size: 36),
          );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _StatusPill(status: project.status),
        const SizedBox(height: 10),
        Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(project.shortDescription, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 18,
          runSpacing: 6,
          children: [
            if (project.budget != null) _Meta(icon: Icons.savings_outlined, text: project.budget!),
            if (project.deadline != null) _Meta(icon: Icons.event_outlined, text: project.deadline!),
          ],
        ),
        const SizedBox(height: 14),
        GhostCta(label: 'En savoir plus', onPressed: () => context.go('/projets/${project.id}')),
      ],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: image),
                  const SizedBox(width: 24),
                  Expanded(flex: 3, child: content),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [image, const SizedBox(height: 16), content],
              ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final ProjectStatus status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      ProjectStatus.enCoursDeFinancement => (AppColors.redSoft, AppColors.red),
      ProjectStatus.planifie => (AppColors.goldSoft, AppColors.gold),
      ProjectStatus.termine => (AppColors.tealSoft, AppColors.teal),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(status.label.toUpperCase(), style: AppTextStyles.eyebrow(fg).copyWith(fontSize: 11.5)),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withValues(alpha: .65);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(text, style: AppTextStyles.mono(size: 13, color: color)),
      ],
    );
  }
}
