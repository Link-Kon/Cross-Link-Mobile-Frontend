import 'package:flutter/material.dart';

import '../../../domain/models/requests/user_request.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'user_state.dart';

class UserCubit extends BaseCubit<UserState, List<User>> {
  final UserApiRepository _apiRepository;

  UserCubit(this._apiRepository) : super(const UserLoading(), []);

  Future<void> addUser({required String username, required String token, required String deviceToken}) async {
    emit(const UserLoading());
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.addUser(
        request: UserRequest(username: username, token: token, deviceToken: deviceToken),
      );

      if (response is DataSuccess) {
        debugPrint('addUser success');
        debugPrint('response: ${response.data!.userCode}');
        final userResponse = response.data!;
        emit(UserSuccess(response: userResponse));



      } else if (response is DataFailed) {
        debugPrint('addUser failed: ${response.error!.response}');
        emit(UserFailed(error: response.error));
      }
    });
  }

  Future<void> getUser({required String username}) async {
    emit(const UserLoading());
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getUser(
        username: username,
      );

      if (response is DataSuccess) {
        debugPrint('getUser success');
        final responseData = response.data!;
        emit(UserGetSuccess(response: responseData));

      } else if (response is DataFailed) {
        debugPrint('getUser failed: ${response.error!.response}');
        emit(UserFailed(error: response.error));
      }
    });
  }

}