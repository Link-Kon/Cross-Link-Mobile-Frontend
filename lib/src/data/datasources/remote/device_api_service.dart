import 'package:cross_link/src/domain/models/responses/user_links_response.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'relationship_api_service.g.dart';

@RestApi(baseUrl: baseUrlRelationshipApi, parser: Parser.MapSerializable)
abstract class DeviceApiService {
  factory DeviceApiService(Dio dio, {String baseUrl}) = _DeviceApiService;

  @GET('/')
  Future<HttpResponse<UserLinksResponse>> getDevices({
    @Query("apiKey") String? apiKey,
    @Query("userDataId") String? userDataId,
  });

}