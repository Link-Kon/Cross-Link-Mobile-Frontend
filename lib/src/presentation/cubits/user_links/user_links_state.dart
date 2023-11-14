import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/responses/base_response.dart';
import '../../../domain/models/responses/user_link_response.dart';

abstract class UserLinksState extends Equatable {
  final List<UserLinkResponse> userLinks;
  final BaseResponse? response;
  final DioException? error;

  const UserLinksState({
    this.userLinks = const [],
    this.response,
    this.error
  });

  @override
  List<Object?> get props => [userLinks, error];
}

class UserLinksLoading extends UserLinksState {
  const UserLinksLoading();
}

class UserLinksSuccess extends UserLinksState {
  const UserLinksSuccess({super.userLinks});
}

class UserLinkAddSuccess extends UserLinksState {
  const UserLinkAddSuccess({super.response});
}

class UserLinksFailed extends UserLinksState {
  const UserLinksFailed({super.error});
}