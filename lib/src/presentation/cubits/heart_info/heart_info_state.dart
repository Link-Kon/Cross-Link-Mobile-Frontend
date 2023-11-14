import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/responses/heart_info_response.dart';

abstract class HeartInfoState extends Equatable {
  final HeartInfoResponse? response;
  final DioException? error;

  const HeartInfoState({
    this.response,
    this.error
  });

  @override
  List<Object?> get props => [response, error];
}

class HeartInfoLoading extends HeartInfoState {
  const HeartInfoLoading();
}

class HeartInfoSuccess extends HeartInfoState {
  const HeartInfoSuccess({super.response});
}

class HeartInfoFailed extends HeartInfoState {
  const HeartInfoFailed({super.error});
}