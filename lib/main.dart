import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'data/association_info.dart';
import 'widgets/site_shell.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/projects_page.dart';
import 'pages/project_detail_page.dart';
import 'pages/support_page.dart';
import 'pages/contact_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MbaheApp());
}

final GoRouter _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          SiteShell(location: state.uri.toString(), child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/association', builder: (context, state) => const AboutPage()),
        GoRoute(path: '/projets', builder: (context, state) => const ProjectsPage()),
        GoRoute(
          path: '/projets/:id',
          builder: (context, state) =>
              ProjectDetailPage(id: state.pathParameters['id']!),
        ),
        GoRoute(path: '/soutenir', builder: (context, state) => const SupportPage()),
        GoRoute(path: '/contact', builder: (context, state) => const ContactPage()),
      ],
    ),
  ],
);

class MbaheApp extends StatelessWidget {
  const MbaheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '${AssociationInfo.brandShort} — ${AssociationInfo.brandTagline}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
