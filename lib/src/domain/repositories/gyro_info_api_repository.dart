import '../../utils/resources/data_state.dart';
import '../models/requests/gyro_info_request.dart';
import '../models/responses/gyro_info_response.dart';

abstract class GyroInfoApiRepository {
  Future<DataState<GyroInfoResponse>> addGyroInfo({
    required GyroInfoRequest request,
  });
}