import 'package:equatable/equatable.dart';

class BaseResponse extends Equatable {
  final bool? success;
  final String? message;

  const BaseResponse({this.success, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      success,
      message,
    ];
  }

}