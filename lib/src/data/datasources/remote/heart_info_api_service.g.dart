// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_info_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _HeartInfoApiService implements HeartInfoApiService {
  _HeartInfoApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??=
        'http://link-backend-ef2-dev.eba-gnkgpdgz.us-east-2.elasticbeanstalk.com/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<HeartInfoResponse>> addHeartInfo(
      {required HeartInfoList list}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(list.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<HeartInfoResponse>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/Extras/GetHeartPrediction',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HeartInfoResponse.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
