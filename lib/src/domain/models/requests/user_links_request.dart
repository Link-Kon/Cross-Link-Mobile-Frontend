class UserLinksRequest {
  final String apiKey;
  final String user1Code;
  final String user2Code;
  final bool state;

  UserLinksRequest({
    this.apiKey = '',
    this.user1Code = '',
    this.user2Code = '',
    this.state = true,
  });
}