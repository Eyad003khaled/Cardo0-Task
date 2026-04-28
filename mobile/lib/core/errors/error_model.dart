class ErrorModel {
  final String errorMessage;
  final dynamic status;
  final int? code; // Add this line

  ErrorModel({
    required this.errorMessage,
    required this.status,
    this.code,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        errorMessage: json['message'] ?? 'Unknown error',
        status: json['status'] ?? false,
        code:  json['statusCode'], 
      );
}
