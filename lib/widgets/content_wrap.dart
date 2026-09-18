import 'package:flutter/material.dart';

/// Centre le contenu avec une largeur de lecture confortable et une
/// marge latérale minimale, quel que soit l'écran.
class ContentWrap extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsets? padding;

  const ContentWrap({
    super.key,
    required this.child,
    this.maxWidth = 1080,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: child,
        ),
      ),
    );
  }
}
