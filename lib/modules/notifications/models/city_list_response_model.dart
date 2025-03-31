class CityListResponseModel {
  final List<CityModel> row;
  final int count;

  CityListResponseModel({required this.row, required this.count});

  factory CityListResponseModel.fromJson(Map<String, dynamic> json) {
    return CityListResponseModel(
      row:
          (json['row'] as List<dynamic>?)
              ?.map((e) => CityModel.fromJson(e))
              .toList() ??
          [],
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'row': row.map((e) => e.toJson()).toList(), 'count': count};
  }
}

class CityModel {
  final int id;
  final String name;

  CityModel({required this.id, required this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
