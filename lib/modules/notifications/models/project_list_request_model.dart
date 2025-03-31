class ProjectListRequestModel {
  final int page;
  final int limit;
  final String? search;
  final int? cityId;

  ProjectListRequestModel({
    this.page = 1,
    this.limit = 10,
    this.search,
    this.cityId,
  });

  factory ProjectListRequestModel.fromJson(Map<String, dynamic> json) {
    return ProjectListRequestModel(
      page: json['p_page'],
      limit: json['p_limit'],
      search: json['p_search'],
      cityId: json['p_city_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'p_page': page,
      'p_limit': limit,
      'p_search': search,
      'p_city_id': cityId,
    };
  }
}
