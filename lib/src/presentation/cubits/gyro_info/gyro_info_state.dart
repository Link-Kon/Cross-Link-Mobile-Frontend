import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/responses/gyro_info_response.dart';

abstract class GyroInfoState extends Equatable {
  final GyroInfoResponse? response;
  final DioException? error;

  const GyroInfoState({
    this.response,
    this.error
  });

  @override
  List<Object?> get props => [response, error];
}

class GyroInfoLoading extends GyroInfoState {
  const GyroInfoLoading();
}

class GyroInfoSuccess extends GyroInfoState {
  const GyroInfoSuccess({super.response});
}

class GyroInfoFailed extends GyroInfoState {
  const GyroInfoFailed({super.error});
}