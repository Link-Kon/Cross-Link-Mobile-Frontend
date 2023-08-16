import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/illness.dart';
import '../../../utils/constants/strings.dart';

part 'illness_api_service.g.dart';

@RestApi(baseUrl: baseUrlWebService)
abstract class IllnessApiService {
  factory IllnessApiService(Dio dio, {String baseUrl}) = _IllnessApiService;

  @GET('/Illness')
  Future<HttpResponse<List<Illness>>> getAllIllnesses();

}