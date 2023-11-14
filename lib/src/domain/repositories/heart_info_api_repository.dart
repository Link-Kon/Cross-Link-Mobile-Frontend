import '../../utils/resources/data_state.dart';
import '../models/requests/heart_info_request.dart';
import '../models/responses/heart_info_response.dart';

abstract class HeartInfoApiRepository {
  Future<DataState<HeartInfoResponse>> addHeartInfo({
    required HeartInfoRequest request,
  });
}