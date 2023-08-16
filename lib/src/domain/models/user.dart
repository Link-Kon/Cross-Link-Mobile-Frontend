class User {
  final String? username;
  final String? userCode;
  final String? token;

  const User({this.username, this.userCode, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String?,
      userCode: json['userCode'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'code': userCode,
      'token': token,
      'creationDate': "2023-08-16T06:12:56.104Z",
      'lastUpdateDate': "2023-08-16T06:12:56.104Z"
    };
  }

}