import '../heart_info.dart';

class HeartInfoRequest {
  final String userCode;
  final String username;
  final List<HeartInfo> list;

  HeartInfoRequest({
    required this.userCode,
    required this.username,
    required this.list,
  });
}