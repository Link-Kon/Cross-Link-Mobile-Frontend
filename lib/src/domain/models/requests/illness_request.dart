class IllnessRequest {
  final String apiKey;
  final String userDataId;

  IllnessRequest({
    this.apiKey = 'token', //TODO: make dynamic
    this.userDataId = '1', //TODO: make dynamic
  });
}