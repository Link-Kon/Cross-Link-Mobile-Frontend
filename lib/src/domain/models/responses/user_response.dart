import 'package:equatable/equatable.dart';

import 'base_response.dart';

class UserResponse extends Equatable {
  final String token;
  final String userCode;
  final String id;
  final String name;
  final String lastname;
  final String email;
  //final BaseResponse? response;

  const UserResponse({
    required this.token,
    required this.userCode,
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    //required this.response
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      token: json['token'] ?? '',
      userCode: json['userCode'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      //response: BaseResponse.fromJson(json['itemResource'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      token,
      userCode,
      id,
      name,
      lastname,
      email,
      //response,
    ];
  }

}