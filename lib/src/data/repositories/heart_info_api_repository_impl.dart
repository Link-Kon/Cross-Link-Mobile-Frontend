import '../../domain/models/heart_info_list.dart';
import '../../domain/models/requests/heart_info_request.dart';
import '../../domain/models/responses/heart_info_response.dart';
import '../../domain/repositories/heart_info_api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/heart_info_api_service.dart';
import 'base/base_api_repository.dart';

class HeartInfoApiRepositoryImpl extends BaseApiRepository implements HeartInfoApiRepository {
  final HeartInfoApiService _heartInfoApiService;

  HeartInfoApiRepositoryImpl(this._heartInfoApiService);

  @override
  Future<DataState<HeartInfoResponse>> addHeartInfo({required HeartInfoRequest request}) {
    return getStateOf<HeartInfoResponse>(
        request: () => _heartInfoApiService.addHeartInfo(
            list: HeartInfoList(
              userCode: request.userCode,
              username: request.username,
              list: request.list,
            )
        )
    );
  }


}