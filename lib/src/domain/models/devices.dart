import 'package:equatable/equatable.dart';

class Devices extends Equatable {
  final int? id;
  final String? nickname;
  final String? model;
  final String? version;
  final String? state;
  final String? imageUrl;

  const Devices({this.id, this.nickname, this.model, this.version, this.state, this.imageUrl});

  factory Devices.fromMap(Map<String, dynamic> map) {
    return Devices(
      id: map['id'] != null ? map['id'] as int : null,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      version: map['version'] != null ? map['version'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      nickname,
      model,
      version,
      state,
      imageUrl,
    ];
  }

}