class UserRequest {
  final String username;
  //final String code;
  final String token;
  final String deviceToken;

  UserRequest({
    required this.username,
    //required this.code,
    required this.token,
    required this.deviceToken,
  });
}