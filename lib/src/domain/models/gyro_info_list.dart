import 'gyro_info.dart';

class GyroInfoList {
  final String? userCode;
  final String? username;
  final double? prediction;
  final List<GyroInfo>? list;

  const GyroInfoList({this.userCode, this.username, this.prediction, this.list});

  factory GyroInfoList.fromJson(Map<String, dynamic> json) {
    return GyroInfoList(
      userCode: json['userCode'] as String?,
      username: json['username'] as String?,
      prediction: json['prediction'] as double?,
      list: List<GyroInfo>.from(
        json['gyros'].map<GyroInfo>(
              (x) => GyroInfo.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userCode': userCode,
      'username': username,
      'gyros': list!.map((gyroInfo) => gyroInfo.toJson()).toList(),
    };
  }

}