class BaseResponseModel<T> {
  final bool status;
  final String message;
  final T? data;

  BaseResponseModel({required this.status, required this.message, this.data});

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? fromJsonT,
  }) => BaseResponseModel(
    status: json['status'],
    message: json['message'],
    data:
        json['data'] != null && fromJsonT != null
            ? fromJsonT(json['data'])
            : null,
  );

  Map<String, dynamic> toJson({Map<String, dynamic> Function(T)? toJsonT}) => {
    'status': status,
    'message': message,
    if (data != null && toJsonT != null) 'data': toJsonT(data as T),
  };
}
