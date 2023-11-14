import 'heart_info.dart';

class HeartInfoList {
  final String? userCode;
  final String? username;
  final double? prediction;
  final List<HeartInfo>? list;

  const HeartInfoList({this.userCode, this.username, this.prediction, this.list});

  factory HeartInfoList.fromJson(Map<String, dynamic> json) {
    return HeartInfoList(
      userCode: json['userCode'] as String?,
      username: json['username'] as String?,
      prediction: json['prediction'] as double?,
      list: List<HeartInfo>.from(
        json['reds'].map<HeartInfo>(
              (x) => HeartInfo.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userCode': userCode,
      'username': username,
      'reds': list!.map((heartInfo) => heartInfo.toJson()).toList(),
    };
  }

}