import 'package:equatable/equatable.dart';

import 'base_response.dart';

class UserPatientResponse extends Equatable {
  final int id;
  final bool state;
  final double weight;
  final double height;
  final String country;
  final int userDataId;
  //final BaseResponse? response;

  const UserPatientResponse({
    required this.id,
    required this.state,
    required this.weight,
    required this.height,
    required this.country,
    required this.userDataId,
    //required this.response
  });

  factory UserPatientResponse.fromJson(Map<String, dynamic> json) {
    return UserPatientResponse(
      id: json['id'] ?? 0,
      state: json['state'] ?? false,
      weight: json['weight'] ?? 0,
      height: json['height'] ?? 0,
      country: json['country'] ?? '',
      userDataId: json['userDataId'] ?? 0,
      //response: BaseResponse.fromJson(json['itemResource'] as Map<String, dynamic>),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      state,
      weight,
      height,
      country,
      userDataId,
      //response,
    ];
  }

}