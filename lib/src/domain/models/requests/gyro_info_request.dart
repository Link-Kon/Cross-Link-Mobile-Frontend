import '../gyro_info.dart';

class GyroInfoRequest {
  final String userCode;
  final String username;
  final List<GyroInfo> list;

  GyroInfoRequest({
    required this.userCode,
    required this.username,
    required this.list,
  });
}