class ProjectListResponseModel {
  final List<ProjectModel> row;
  final int count;

  ProjectListResponseModel({required this.row, required this.count});

  factory ProjectListResponseModel.fromJson(Map<String, dynamic> json) {
    return ProjectListResponseModel(
      row:
          (json['row'] as List<dynamic>?)
              ?.map((e) => ProjectModel.fromJson(e))
              .toList() ??
          [],
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'row': row.map((e) => e.toJson()).toList(), 'count': count};
  }
}

class ProjectModel {
  final int id;
  final String name;

  ProjectModel({required this.id, required this.name});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
