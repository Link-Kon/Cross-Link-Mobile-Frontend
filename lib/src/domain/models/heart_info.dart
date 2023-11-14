class HeartInfo {
  final double? red;
  final double? infraRed;

  const HeartInfo({
    this.red,
    this.infraRed,
  });

  factory HeartInfo.fromJson(Map<String, dynamic> json) {
    return HeartInfo(
      red: json['red'] as double?,
      infraRed: json['infraRed'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'red': red,
      'infraRed': infraRed,
    };
  }

}