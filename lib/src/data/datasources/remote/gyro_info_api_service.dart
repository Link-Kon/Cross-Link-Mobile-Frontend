import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/gyro_info_list.dart';
import '../../../domain/models/responses/gyro_info_response.dart';
import '../../../utils/constants/strings.dart';

part 'gyro_info_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class GyroInfoApiService {
  factory GyroInfoApiService(Dio dio, {String baseUrl}) = _GyroInfoApiService;

  @POST('/Extras/GetGyroPrediction')
  Future<HttpResponse<GyroInfoResponse>> addGyroInfo({
    @Body() required GyroInfoList list,
  });

}