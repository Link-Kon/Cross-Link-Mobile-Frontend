class UserPatientRequest {
  final bool state;
  final double weight;
  final double height;
  final String country;
  final int userDataId;

  UserPatientRequest({
    required this.state,
    required this.weight,
    required this.height,
    required this.country,
    required this.userDataId,
  });
}