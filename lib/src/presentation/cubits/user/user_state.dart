import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/responses/user_response.dart';

abstract class UserState extends Equatable {
  final UserResponse? response;
  final DioException? error;

  const UserState({
    this.response,
    this.error
  });

  @override
  List<Object?> get props => [response, error];
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserSuccess extends UserState {
  const UserSuccess({super.response});
}

class UserFailed extends UserState {
  const UserFailed({super.error});
}