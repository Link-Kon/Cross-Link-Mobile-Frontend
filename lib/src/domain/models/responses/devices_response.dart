
import 'package:cross_link/src/domain/models/devices.dart';
import 'package:equatable/equatable.dart';

class DevicesResponse extends Equatable {
  final String status;
  final int totalResults;
  final List<Devices> devices;

  const DevicesResponse({
    required this.status,
    required this.totalResults,
    required this.devices
  });

  factory DevicesResponse.fromMap(Map<String, dynamic> map) {
    return DevicesResponse(
      status: (map['status'] ?? '') as String,
      totalResults: (map['totalResults'] ?? 0) as int,
      devices: List<Devices>.from(
        (map['devices'] as List<int>).map<Devices>(
              (x) => Devices.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, totalResults, devices];

}