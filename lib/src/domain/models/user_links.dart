import 'package:equatable/equatable.dart';

class UserLinks extends Equatable {
  final int? id;
  final String? name;
  final String? linkDate;
  final String? imageUrl;

  const UserLinks({this.id, this.name, this.linkDate, this.imageUrl});

  factory UserLinks.fromMap(Map<String, dynamic> map) {
    return UserLinks(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      linkDate: map['linkDate'] != null ? map['linkDate'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      linkDate,
      imageUrl,
    ];
  }

}