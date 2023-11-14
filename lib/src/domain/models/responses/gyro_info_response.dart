import 'package:equatable/equatable.dart';

import 'base_response.dart';

class GyroInfoResponse extends Equatable {
  final String prediction;
  final BaseResponse? response;

  const GyroInfoResponse({
    required this.prediction,
    required this.response
  });

  factory GyroInfoResponse.fromJson(Map<String, dynamic> json) {
    return GyroInfoResponse(
      prediction: json['output'] ?? '',
      response: BaseResponse.fromJson(json['itemResource'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      prediction,
      response,
    ];
  }

}