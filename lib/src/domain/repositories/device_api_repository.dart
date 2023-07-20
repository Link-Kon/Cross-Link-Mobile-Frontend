import 'package:cross_link/src/domain/models/requests/devices_request.dart';
import 'package:cross_link/src/domain/models/responses/devices_response.dart';
import 'package:cross_link/src/utils/resources/data_state.dart';

abstract class DeviceApiRepository {
  Future<DataState<DevicesResponse>> getDevices({
    required DevicesRequest request,
  });
}