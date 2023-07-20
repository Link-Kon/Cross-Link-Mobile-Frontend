import 'package:cross_link/src/data/datasources/remote/device_api_service.dart';
import 'package:cross_link/src/data/repositories/base_api_repository.dart';
import 'package:cross_link/src/domain/models/requests/devices_request.dart';
import 'package:cross_link/src/domain/models/responses/devices_response.dart';
import 'package:cross_link/src/domain/repositories/device_api_repository.dart';
import 'package:cross_link/src/utils/resources/data_state.dart';

class DeviceApiRepositoryImpl extends BaseApiRepository implements DeviceApiRepository {
  final DeviceApiService _deviceApiService;

  DeviceApiRepositoryImpl(this._deviceApiService);

  @override
  Future<DataState<DevicesResponse>> getDevices({required DevicesRequest request}) {
    return getStateOf<DevicesResponse>(
      request: () => _deviceApiService.getDevices(
        apiKey: request.apiKey,
        userDataId: request.userDataId,
      )
    );
  }



}