import 'package:equatable/equatable.dart';

class Illness extends Equatable {
  final int? id;
  final String? name;
  final String? description;

  const Illness({this.id, this.name, this.description});

  factory Illness.fromJson(Map<String, dynamic> json) {
    return Illness(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
    ];
  }

}