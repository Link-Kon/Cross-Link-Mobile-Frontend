class UserRequest {
  final String username;
  final String userCode;
  final String token;
  final String deviceToken;

  UserRequest({
    required this.username,
    this.userCode = '',
    required this.token,
    required this.deviceToken,
  });
}