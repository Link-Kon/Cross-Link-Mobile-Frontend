import 'package:equatable/equatable.dart';

class UserLink extends Equatable {
  final int? id;
  final String? name;
  final String? user2code;
  final bool? state;
  final String? linkDate;
  final String? imageUrl;

  const UserLink({this.id, this.name, this.user2code, this.state, this.linkDate, this.imageUrl});

  factory UserLink.fromJson(Map<String, dynamic> json) {
    return UserLink(
      id: json['id'] as int?,
      name: json['name'] as String?,
      user2code: json['user2Code'] as String,
      state: json['state'] as bool,
      linkDate: json['linkDate'] as String?,
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
      user2code,
      state,
      linkDate,
      imageUrl,
    ];
  }

}