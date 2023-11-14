import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class WearableState extends Equatable {
  final BluetoothDevice? device;
  final DioException? error;

  const WearableState({
    this.device,
    this.error
  });

  @override
  List<Object?> get props => [device, error];
}

class WearableLoading extends WearableState {
  const WearableLoading();
}

class WearableSuccess extends WearableState {
  const WearableSuccess({super.device});
}

class WearableFailed extends WearableState {
  const WearableFailed({super.error});
}