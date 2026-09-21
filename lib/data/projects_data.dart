import 'package:flutter/widgets.dart' show Alignment;
import '../models/project.dart';

/// Tous les projets de l'association affichés dans l'onglet « Nos projets ».
///
/// Pour ajouter un nouveau projet, copiez le modèle ci-dessous et ajoutez-le
/// à la liste — il apparaîtra automatiquement dans la liste et sa page
/// de détail (route `/projets/<id>`).
final List<Project> projects = [
  Project(
    id: 'ecole-mbahe-2',
    title: "Deuxième école de M'bahé",
    shortDescription:
        "Construire une deuxième école pour que les enfants de l'autre rive du marigot n'aient plus à traverser en pirogue.",
    body: [
      "M'bahé est un village de la région du Brakna, en Mauritanie, coupé en deux par un marigot. De juillet à novembre, pendant la saison des pluies, le marigot gonfle et rend le radier — l'ouvrage en béton qui sert normalement de passage — infranchissable.",
      "Les enfants qui habitent de l'autre côté du village doivent alors traverser en pirogue pour rejoindre l'école, un déplacement non sécurisé qu'ils répètent chaque jour de classe pendant près de cinq mois par an.",
      "La première école du village est par ailleurs saturée : trop d'élèves pour trop peu de classes. Le problème n'est donc pas seulement l'accès pendant la saison des pluies, mais aussi la capacité d'accueil toute l'année.",
      "Notre réponse : construire une deuxième école positionnée pour desservir les deux rives, afin qu'aucun enfant n'ait plus à dépendre du radier ou de la pirogue pour être scolarisé.",
    ],
    status: ProjectStatus.enCoursDeFinancement,
    budget: '20 000 €',
    deadline: 'Avant juillet 2027',
    zone: "M'bahé, Brakna, Mauritanie",
    imageAsset: 'assets/images/pirogue-ecoliers.jpg',
    fundingLeads: [
      'PRA/OSIM — FORIM',
      'Région Île-de-France — Actions internationales',
      'Cités Unies France — jumelage',
    ],
    gallery: [
      GalleryPhoto(
        asset: 'assets/images/pirogue-ecoliers.jpg',
        caption: 'La traversée quotidienne en pirogue pendant la saison des pluies.',
        alignment: Alignment.topCenter,
      ),
      GalleryPhoto(
        asset: 'assets/images/pirogue-groupe.jpg',
        caption: 'Plusieurs enfants traversent ensemble, cartables sur le dos.',
        alignment: Alignment.topCenter,
      ),
      GalleryPhoto(
        asset: 'assets/images/pirogue-rive.jpg',
        caption: 'La pirogue accoste près du village.',
        alignment: Alignment.topCenter,
      ),
      GalleryPhoto(
        asset: 'assets/images/classe-garcons-saturee.jpg',
        caption: "L'école actuelle, aujourd'hui saturée.",
      ),
      GalleryPhoto(
        asset: 'assets/images/classe-filles-saturee.jpg',
        caption: 'Une salle de classe pleine — plus de places disponibles.',
      ),
    ],
  ),

  // Project(
  //   id: 'mon-prochain-projet',
  //   title: 'Titre du projet',
  //   shortDescription: 'Résumé en une phrase.',
  //   body: ['Paragraphe 1…', 'Paragraphe 2…'],
  //   status: ProjectStatus.planifie,
  //   budget: '0 €',
  //   deadline: 'À préciser',
  //   zone: "M'bahé, Brakna, Mauritanie",
  //   imageAsset: null,
  //   fundingLeads: [],
  // ),
];
