import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/user_link.dart';

abstract class UserLinksState extends Equatable {
  final List<UserLink> userLinks;
  final DioException? error;

  const UserLinksState({
    this.userLinks = const [],
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

class UserLinksFailed extends UserLinksState {
  const UserLinksFailed({super.error});
}