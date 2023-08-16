import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/device.dart';
import '../../../utils/constants/strings.dart';

part 'device_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class DeviceApiService {
  factory DeviceApiService(Dio dio, {String baseUrl}) = _DeviceApiService;

  @GET('/')
  Future<HttpResponse<List<Device>>> getDevices({
    @Query("apiKey") String? apiKey,
    @Query("userDataId") String? userDataId,
  });

}