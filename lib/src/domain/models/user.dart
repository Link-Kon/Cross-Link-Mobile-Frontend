class User {
  final String? id;
  final String? username;
  final String? code;
  final String? token;
  final String? deviceToken;

  const User({this.id,this.username, this.code, this.token, this.deviceToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      code: json['userCode'] as String?,
      token: json['token'] as String?,
      deviceToken: json['deviceToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'userCode': code,
      'token': token,
      'deviceToken': deviceToken,
    };
  }

}