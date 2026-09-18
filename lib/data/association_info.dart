/// Coordonnées et informations légales de l'association.
///
/// Regroupées ici pour être modifiées à un seul endroit. Identifiants
/// légaux repris du récépissé de la préfecture de police et de la fiche
/// SIRENE (INSEE).
class AssociationInfo {
  AssociationInfo._();

  /// Nom court affiché dans la navigation et le pied de page.
  static const String brandShort = 'ARDM';

  /// Complète le nom court dans l'en-tête et le titre du site.
  static const String brandTagline = "Association des Ressortissants de M'bahé";

  /// Dénomination légale exacte (préfecture de police / SIRENE).
  static const String legalName = "Association des Ressortissants pour le Développement de M'bahé";

  static const String rna = 'W751168380';
  static const String siret = '912 180 361 00012';
  static const String siren = '912 180 361';
  static const String since = '2004';

  static const String email = 'ardm.europe@gmail.com';
  static const String phone = '+33 7 59 84 54 48';
  static const String address = 'Paris, France';
  static const String zone = "M'bahé, Brakna, Mauritanie";
}
