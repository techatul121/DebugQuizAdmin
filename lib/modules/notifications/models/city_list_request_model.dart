class CityListRequestModel {
  final int page;
  final int limit;
  final String? search;

  CityListRequestModel({this.page = 1, this.limit = 10, this.search});

  factory CityListRequestModel.fromJson(Map<String, dynamic> json) {
    return CityListRequestModel(
      page: json['p_page'],
      limit: json['p_limit'],
      search: json['p_search'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'p_page': page, 'p_limit': limit, 'p_search': search};
  }
}
