import 'package:flutter/material.dart';

import '../../../domain/models/gyro_info.dart';
import '../../../domain/models/requests/gyro_info_request.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/gyro_info_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'gyro_info_state.dart';

class GyroInfoCubit extends BaseCubit<GyroInfoState, List<User>> {
  final GyroInfoApiRepository _apiRepository;

  GyroInfoCubit(this._apiRepository) : super(const GyroInfoLoading(), []);

  Future<void> addGyroInfo({required String userCode, required String username, required List<GyroInfo> list}) async {
    data.clear();

    emit(const GyroInfoLoading());
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.addGyroInfo(
        request: GyroInfoRequest(
          userCode: userCode,
          username: username,
          list: list,
        ),
      );

      if (response is DataSuccess) {
        debugPrint('addGyroInfo success');
        print('prediction: ${response.data!.prediction}');
        print('message: ${response.data!.response!.message}');
        final bodyInfoResponse = response.data;
        emit(GyroInfoSuccess(response: bodyInfoResponse));

      } else if (response is DataFailed) {
        debugPrint('addGyroInfo failed: ${response.error!.response}');
        emit(GyroInfoFailed(error: response.error));
      }
    });
  }

}