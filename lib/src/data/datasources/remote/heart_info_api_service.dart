import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/heart_info_list.dart';
import '../../../domain/models/responses/heart_info_response.dart';
import '../../../utils/constants/strings.dart';

part 'heart_info_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class HeartInfoApiService {
  factory HeartInfoApiService(Dio dio, {String baseUrl}) = _HeartInfoApiService;

  @POST('/Extras/GetHeartPrediction')
  Future<HttpResponse<HeartInfoResponse>> addHeartInfo({
    @Body() required HeartInfoList list,
  });

}