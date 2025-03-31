import 'dart:convert';

DashboardDataResponseModel dashboardDataResponseModelFromJson(String str) =>
    DashboardDataResponseModel.fromJson(json.decode(str));

String dashboardDataResponseModelToJson(DashboardDataResponseModel data) =>
    json.encode(data.toJson());

class DashboardDataResponseModel {
  final UserCount registeredUsers;
  final UserCount activeUsers;
  final TopSearches topSearches;
  final ActiveUserGraph activeUserGraph;

  DashboardDataResponseModel({
    required this.registeredUsers,
    required this.activeUsers,
    required this.topSearches,
    required this.activeUserGraph,
  });

  factory DashboardDataResponseModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataResponseModel(
        registeredUsers: UserCount.fromJson(json['registered_users']),
        activeUsers: UserCount.fromJson(json['active_users']),
        topSearches: TopSearches.fromJson(json['top_searches']),
        activeUserGraph: ActiveUserGraph.fromJson(json['active_user_graph']),
      );

  Map<String, dynamic> toJson() => {
    'registered_users': registeredUsers.toJson(),
    'active_users': activeUsers.toJson(),
    'top_searches': topSearches.toJson(),
    'active_user_graph': activeUserGraph.toJson(),
  };
}

class ActiveUserGraph {
  final String title;
  final String xAxisLabel;
  final String yAxisLabel;
  final List<DateTime> xAxisRange;
  final int xAxisInterval;
  final List<int> yAxisRange;
  final int yAxisInterval;
  final List<ActiveUserValue> value;

  ActiveUserGraph({
    required this.title,
    required this.xAxisLabel,
    required this.yAxisLabel,
    required this.xAxisRange,
    required this.xAxisInterval,
    required this.yAxisRange,
    required this.yAxisInterval,
    required this.value,
  });

  factory ActiveUserGraph.fromJson(Map<String, dynamic> json) =>
      ActiveUserGraph(
        title: json['title'],
        xAxisLabel: json['xAxisLabel'],
        yAxisLabel: json['yAxisLabel'],
        xAxisRange:
            !json['xAxisRange'].contains(null)
                ? List<DateTime>.from(
                  json['xAxisRange'].map((x) => DateTime.parse(x).toLocal()),
                )
                : [],
        xAxisInterval: json['xAxisInterval'] ?? 0,
        yAxisRange:
            !json['yAxisRange'].contains(null)
                ? List<int>.from(json['yAxisRange'].map((x) => x))
                : [],
        yAxisInterval: json['yAxisInterval'],
        value:
            json['value'] != null
                ? List<ActiveUserValue>.from(
                  json['value'].map((x) => ActiveUserValue.fromJson(x)),
                )
                : [],
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'xAxisLabel': xAxisLabel,
    'yAxisLabel': yAxisLabel,
    'xAxisRange': List<dynamic>.from(
      xAxisRange.map(
        (x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}",
      ),
    ),
    'xAxisInterval': xAxisInterval,
    'yAxisRange': List<dynamic>.from(yAxisRange.map((x) => x)),
    'yAxisInterval': yAxisInterval,
    'value': List<dynamic>.from(value.map((x) => x.toJson())),
  };
}

class ActiveUserValue {
  final DateTime date;
  final int users;

  ActiveUserValue({required this.date, required this.users});

  factory ActiveUserValue.fromJson(Map<String, dynamic> json) =>
      ActiveUserValue(
        date: DateTime.parse(json['date']).toLocal(),
        users: json['users'],
      );

  Map<String, dynamic> toJson() => {
    'date':
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    'users': users,
  };
}

class UserCount {
  final String title;
  final int value;

  UserCount({required this.title, required this.value});

  factory UserCount.fromJson(Map<String, dynamic> json) =>
      UserCount(title: json['title'], value: json['value']);

  Map<String, dynamic> toJson() => {'title': title, 'value': value};
}

class TopSearches {
  final String title;
  final List<String> value;

  TopSearches({required this.title, required this.value});

  factory TopSearches.fromJson(Map<String, dynamic> json) => TopSearches(
    title: json['title'],
    value: List<String>.from(json['value'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'value': List<dynamic>.from(value.map((x) => x)),
  };
}
