import '../../domain/models/device.dart';
import '../../domain/models/requests/devices_request.dart';
import '../../domain/repositories/device_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/device_api_service.dart';
import 'base/base_api_repository.dart';

class DeviceApiRepositoryImpl extends BaseApiRepository implements DeviceApiRepository {
  final DeviceApiService _deviceApiService;

  DeviceApiRepositoryImpl(this._deviceApiService);

  @override
  Future<DataState<List<Device>>> getDevices({required DevicesRequest request}) {
    return getStateOf<List<Device>>(
      request: () => _deviceApiService.getDevices(
        apiKey: request.apiKey,
        userDataId: request.userDataId,
      )
    );
  }



}