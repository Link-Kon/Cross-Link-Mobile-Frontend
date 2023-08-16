import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final int? id;
  final String? nickname;
  final String? model;
  final String? version;
  final String? state;
  final String? imageUrl;

  const Device({this.id, this.nickname, this.model, this.version, this.state, this.imageUrl});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      model: json['model'] as String,
      version: json['version'] as String,
      state: json['state'] as String,
      imageUrl: json['imageUrl'] as String,
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