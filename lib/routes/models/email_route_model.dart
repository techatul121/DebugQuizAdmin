class EmailRouteModel {
  final String email;

  EmailRouteModel({required this.email});

  factory EmailRouteModel.fromJson(Map<String, dynamic> json) =>
      EmailRouteModel(email: json['email']);

  Map<String, dynamic> toJson() => {'email': email};
}
