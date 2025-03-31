class MostSearchedProjectsResponseModel {
  final List<String> mostSearchedProjects;

  MostSearchedProjectsResponseModel({required this.mostSearchedProjects});

  factory MostSearchedProjectsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => MostSearchedProjectsResponseModel(
    mostSearchedProjects: List<String>.from(
      json['most_searched_projects'].map((x) => x),
    ),
  );

  Map<String, dynamic> toJson() => {
    'most_searched_projects': List<dynamic>.from(
      mostSearchedProjects.map((x) => x),
    ),
  };
}
