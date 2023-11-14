import 'package:flutter/material.dart';

import '../../../domain/models/heart_info.dart';
import '../../../domain/models/requests/heart_info_request.dart';
import '../../../domain/repositories/heart_info_api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'heart_info_state.dart';

class HeartInfoCubit extends BaseCubit<HeartInfoState, List<HeartInfo>> {
  final HeartInfoApiRepository _apiRepository;

  HeartInfoCubit(this._apiRepository) : super(const HeartInfoLoading(), []);

  Future<void> addHeartInfo({required String userCode, required String username, required List<HeartInfo> list}) async {
    data.clear();

    emit(const HeartInfoLoading());
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.addHeartInfo(
        request: HeartInfoRequest(
          userCode: userCode,
          username: username,
          list: list,
        ),
      );

      if (response is DataSuccess) {
        debugPrint('addHeartInfo success');
        print('prediction: ${response.data!.prediction}');
        print('message: ${response.data!.response!.message}');
        final bodyInfoResponse = response.data;
        emit(HeartInfoSuccess(response: bodyInfoResponse));

      } else if (response is DataFailed) {
        debugPrint('addHeartInfo failed: ${response.error!.response}');
        emit(HeartInfoFailed(error: response.error));
      }
    });
  }

}