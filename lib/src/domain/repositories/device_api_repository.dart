import '../../utils/resources/data_state.dart';
import '../models/device.dart';
import '../models/requests/devices_request.dart';

abstract class DeviceApiRepository {
  Future<DataState<List<Device>>> getDevices({
    required DevicesRequest request,
  });
}