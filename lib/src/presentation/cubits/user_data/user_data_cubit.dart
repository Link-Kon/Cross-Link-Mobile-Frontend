import 'package:flutter/material.dart';

import '../../../domain/models/requests/user_data_request.dart';
import '../../../domain/models/user_data.dart';
import '../../../domain/repositories/user_data_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'user_data_state.dart';

class UserDataCubit extends BaseCubit<UserDataState, List<UserData>> {
  final UserDataApiRepository _apiRepository;

  UserDataCubit(this._apiRepository) : super(const UserDataLoading(), []);

  Future<void> addUserData({required String email, required String name, required String lastname,
    required String photoUrl, required String userCode
  }) async {

    emit(const UserDataLoading());

    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.addUserData(
        request: UserDataRequest(state: true, email: email, name: name, lastname: lastname,
          photo: photoUrl, code: userCode
        ),
      );

      if (response is DataSuccess) {
        debugPrint('addUserData success');
        final userDataResponse = response.data!;
        emit(UserDataSuccess(response: userDataResponse));


      } else if (response is DataFailed) {
        debugPrint('addUserData failed: ${response.error!.response}');
        emit(UserDataFailed(error: response.error));
      }
    });
  }

  Future<void> getUserData({required String userCode}) async {
    emit(const UserDataLoading());

    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getUserData(
        request: UserDataRequest(code: userCode),
      );

      if (response is DataSuccess) {
        debugPrint('getUserData success');
        final userDataResponse = response.data!;
        emit(UserDataSuccess(response: userDataResponse));


      } else if (response is DataFailed) {
        debugPrint('getUserData failed: ${response.error!.response}');
        emit(UserDataFailed(error: response.error));
      }
    });
  }

}