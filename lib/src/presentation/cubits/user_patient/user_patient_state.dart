import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/responses/patient_response.dart';

abstract class UserPatientState extends Equatable {
  final UserPatientResponse? response;
  final DioException? error;

  const UserPatientState({
    this.response,
    this.error
  });

  @override
  List<Object?> get props => [response, error];
}

class UserPatientLoading extends UserPatientState {
  const UserPatientLoading();
}

class UserPatientSuccess extends UserPatientState {
  const UserPatientSuccess({super.response});
}

class UserPatientFailed extends UserPatientState {
  const UserPatientFailed({super.error});
}