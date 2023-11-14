import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../base/base_cubit.dart';
import 'wearable_state.dart';

class WearableCubit extends BaseCubit<WearableState, BluetoothDevice?> {

  WearableCubit () : super(const WearableLoading(), null);

  Future<void> setDevice({required BluetoothDevice? device}) async {

    emit(const WearableLoading());

    if (isBusy) return;

    await run(() async {
      emit(WearableSuccess(device: device));
    });
  }

}