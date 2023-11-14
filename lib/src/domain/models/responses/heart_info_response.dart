import 'package:equatable/equatable.dart';

import 'base_response.dart';

class HeartInfoResponse extends Equatable {
  final String prediction;
  final BaseResponse? response;

  const HeartInfoResponse({
    required this.prediction,
    required this.response
  });

  factory HeartInfoResponse.fromJson(Map<String, dynamic> json) {
    return HeartInfoResponse(
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