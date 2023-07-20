class UserLinksRequest {
  final String apiKey;
  final String userCode;

  UserLinksRequest({
    this.apiKey = 'token', //TODO: make dynamic
    this.userCode = '1', //TODO: make dynamic
  });
}