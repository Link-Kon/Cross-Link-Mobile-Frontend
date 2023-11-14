class UserData {
  final int? id;
  final bool? state;
  final String? email;
  final String? name;
  final String? lastname;
  final String? photo;
  final int? userId;

  const UserData({
    this.id,
    this.state,
    this.email,
    this.name,
    this.lastname,
    this.photo,
    this.userId
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int?,
      state: json['state'] as bool?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      lastname: json['lastname'] as String?,
      photo: json['userPhoto'] as String?,
      userId: json['userId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'state': state,
      'email': email,
      'name': name,
      'lastname': lastname,
      'userPhoto': photo,
      'userId': userId,
    };
  }

}