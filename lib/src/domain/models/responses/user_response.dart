import 'package:equatable/equatable.dart';

import 'base_response.dart';

class UserResponse extends Equatable {
  final String token;
  final BaseResponse response;

  const UserResponse({required this.token, required this.response});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      token: json['token'] as String,
      response: BaseResponse.fromJson(json['itemResource'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      token,
      response,
    ];
  }

}