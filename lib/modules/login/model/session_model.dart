import 'dart:convert';

SessionModel sessionModelFromJson(String str) =>
    SessionModel.fromJson(json.decode(str));

String sessionModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  final String accessToken;
  final String refreshToken;
  final int expiresAt;
  final int expiresIn;

  SessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.expiresIn,
  });

  SessionModel copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresAt,
    int? expiresIn,
  }) => SessionModel(
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    expiresAt: expiresAt ?? this.expiresAt,
    expiresIn: expiresIn ?? this.expiresIn,
  );

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    accessToken: json['access_token'],
    refreshToken: json['refresh_token'],
    expiresAt: json['expires_at'],
    expiresIn: json['expires_in'],
  );

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'expires_at': expiresAt,
    'expires_in': expiresIn,
  };
}
