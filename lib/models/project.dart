enum ProjectStatus {
  enCoursDeFinancement,
  planifie,
  termine,
}

extension ProjectStatusLabel on ProjectStatus {
  String get label => switch (this) {
        ProjectStatus.enCoursDeFinancement => 'En recherche de financement',
        ProjectStatus.planifie => 'Planifié',
        ProjectStatus.termine => 'Réalisé',
      };
}

class Project {
  final String id;
  final String title;
  final String shortDescription;
  final List<String> body;
  final ProjectStatus status;
  final String? budget;
  final String? deadline;
  final String? zone;
  final String? imageAsset;
  final List<String> fundingLeads;

  const Project({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.body,
    required this.status,
    this.budget,
    this.deadline,
    this.zone,
    this.imageAsset,
    this.fundingLeads = const [],
  });
}
