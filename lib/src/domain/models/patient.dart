class UserPatient {
  final int? id;
  final bool? state;
  final double? weight;
  final double? height;
  final String? country;
  final int? userDataId;

  const UserPatient({
    this.id,
    this.state,
    this.weight,
    this.height,
    this.country,
    this.userDataId
  });

  factory UserPatient.fromJson(Map<String, dynamic> json) {
    return UserPatient(
      id: json['id'] as int?,
      state: json['state'] as bool?,
      weight: json['weight'] as double?,
      height: json['height'] as double?,
      country: json['country'] as String?,
      userDataId: json['userDataId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'state': state,
      'weight': weight,
      'height': height,
      'country': country,
      'userDataId': userDataId,
    };
  }

}