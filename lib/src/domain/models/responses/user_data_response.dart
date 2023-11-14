import 'package:equatable/equatable.dart';

import 'base_response.dart';

class UserDataResponse extends Equatable {
  final int? id;
  final bool? state;
  final String? code;
  final String? email;
  final String? name;
  final String? lastname;
  final String? photo;
  final int? userId;
  final BaseResponse response;

  const UserDataResponse({
    this.id,
    this.state,
    this.code,
    this.email,
    this.name,
    this.lastname,
    this.photo,
    this.userId,
    required this.response
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      id: json['id'] as int?,
      state: json['state'] as bool?,
      code: json['code'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      lastname: json['lastname'] as String?,
      photo: json['userPhoto'] as String?,
      userId: json['userId'] as int?,
      response: BaseResponse.fromJson(json['itemResource'] as Map<String, dynamic>?),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      state,
      code,
      email,
      name,
      lastname,
      photo,
      userId,
      response,
    ];
  }

}