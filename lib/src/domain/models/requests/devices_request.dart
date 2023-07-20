class DevicesRequest {
  final String apiKey;
  final String userDataId;

  DevicesRequest({
    this.apiKey = 'token', //TODO: make dynamic
    this.userDataId = '1', //TODO: make dynamic
  });
}