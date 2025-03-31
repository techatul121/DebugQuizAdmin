class ProjectImageListData {
  final List<String> row;
  final int count;

  ProjectImageListData({required this.row, required this.count});

  factory ProjectImageListData.fromJson(Map<String, dynamic> json) {
    return ProjectImageListData(
      row: List<String>.from(json['row'] ?? []),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'row': row, 'count': count};
  }
}
