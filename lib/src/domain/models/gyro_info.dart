class GyroInfo {
  final double? accelX;
  final double? accelY;
  final double? accelZ;
  final double? rotX;
  final double? rotY;
  final double? rotZ;

const GyroInfo({
  this.accelX, this.accelY,
  this.accelZ,this.rotX,
  this.rotY, this.rotZ
});

  factory GyroInfo.fromJson(Map<String, dynamic> json) {
    return GyroInfo(
      accelX: json['accelX'] as double?,
      accelY: json['accelY'] as double?,
      accelZ: json['accelZ'] as double?,
      rotX: json['rotX'] as double?,
      rotY: json['rotY'] as double?,
      rotZ: json['rotZ'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accelX': accelX,
      'accelY': accelY,
      'accelZ': accelZ,
      'rotX': rotX,
      'rotY': rotY,
      'rotZ': rotZ,
    };
  }

}