import 'package:equatable/equatable.dart';

class UserLinkResponse extends Equatable {
  final int? id;
  final String? name;
  final String? code;
  final bool? state;
  final String? creationDate;
  final String? imageUrl;

  const UserLinkResponse({this.id, this.name, this.code,this.state, this.creationDate, this.imageUrl});

  factory UserLinkResponse.fromJson(Map<String, dynamic> json) {
    return UserLinkResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String,
      state: json['state'] as bool?,
      creationDate: json['creationDate'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      code,
      state,
      creationDate,
      imageUrl,
    ];
  }

}