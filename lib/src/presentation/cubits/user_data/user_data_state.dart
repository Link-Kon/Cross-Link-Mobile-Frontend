import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/responses/user_data_response.dart';

abstract class UserDataState extends Equatable {
  final UserDataResponse? response;
  final DioException? error;

  const UserDataState({
    this.response,
    this.error
  });

  @override
  List<Object?> get props => [response, error];
}

class UserDataLoading extends UserDataState {
  const UserDataLoading();
}

class UserDataSuccess extends UserDataState {
  const UserDataSuccess({super.response});
}

class UserDataFailed extends UserDataState {
  const UserDataFailed({super.error});
}