import 'package:flutter/material.dart';

import '../../../domain/models/requests/patient_request.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_patient_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'user_patient_state.dart';

class UserPatientCubit extends BaseCubit<UserPatientState, List<User>> {
  final UserPatientApiRepository _apiRepository;

  UserPatientCubit(this._apiRepository) : super(const UserPatientLoading(), []);

  Future<void> addUserPatient({required bool state, required double weight, required double height,
    required String country, required int userDataId}) async {

    emit(const UserPatientLoading());
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.addUserPatient(
        request: UserPatientRequest(
          state: state,
          weight: weight,
          height: height,
          country: country,
          userDataId: userDataId
        ),
      );

      if (response is DataSuccess) {
        debugPrint('addUserPatient success');
        final userResponse = response.data!;
        emit(UserPatientSuccess(response: userResponse));

      } else if (response is DataFailed) {
        debugPrint('addUserPatient failed: ${response.error!.response}');
        emit(UserPatientFailed(error: response.error));
      }
    });
  }

  Future<void> getUserPatient({required String username}) async {
    emit(const UserPatientLoading());

    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getUserPatient(
        username: username,
      );

      if (response is DataSuccess) {
        debugPrint('getUserPatient success');
        final userResponse = response.data!;
        emit(UserPatientSuccess(response: userResponse));

      } else if (response is DataFailed) {
        debugPrint('getUserPatient failed: ${response.error!.response}');
        emit(UserPatientFailed(error: response.error));
      }
    });
  }

}