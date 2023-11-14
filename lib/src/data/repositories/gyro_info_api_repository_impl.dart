import '../../domain/models/gyro_info_list.dart';
import '../../domain/models/requests/gyro_info_request.dart';
import '../../domain/models/responses/gyro_info_response.dart';
import '../../domain/repositories/gyro_info_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/gyro_info_api_service.dart';
import 'base/base_api_repository.dart';

class GyroInfoApiRepositoryImpl extends BaseApiRepository implements GyroInfoApiRepository {
  final GyroInfoApiService _bodyInfoApiService;

  GyroInfoApiRepositoryImpl(this._bodyInfoApiService);

  @override
  Future<DataState<GyroInfoResponse>> addGyroInfo({required GyroInfoRequest request}) {
    return getStateOf<GyroInfoResponse>(
        request: () => _bodyInfoApiService.addGyroInfo(
            list: GyroInfoList(
              userCode: request.userCode,
              username: request.username,
              list: request.list,
            )
        )
    );
  }


}