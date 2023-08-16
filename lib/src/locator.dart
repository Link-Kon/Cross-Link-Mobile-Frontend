import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/illness_api_service.dart';
import 'data/datasources/remote/relationship_api_service.dart';
import 'data/datasources/remote/user_api_service.dart';
import 'data/repositories/illness_api_repository_impl.dart';
import 'data/repositories/relationship_api_repository_impl.dart';
import 'data/repositories/user_api_repository_impl.dart';
import 'domain/repositories/illness_api_repository.dart';
import 'domain/repositories/relationship_api_repository.dart';
import 'domain/repositories/user_api_repository.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();

  locator.registerSingleton<Dio>(dio);

  //User links - relationship
  locator.registerSingleton<RelationshipApiService>(
    RelationshipApiService(locator<Dio>()),
  );
  locator.registerSingleton<RelationshipApiRepository>(
    RelationshipApiRepositoryImpl(locator<RelationshipApiService>()),
  );

  //Illness
  locator.registerSingleton<IllnessApiService>(
    IllnessApiService(locator<Dio>(), baseUrl: baseUrlWebService),
  );
  locator.registerSingleton<IllnessApiRepository>(
    IllnessApiRepositoryImpl(locator<IllnessApiService>()),
  );

  //Users
  locator.registerSingleton<UserApiService>(
    UserApiService(locator<Dio>(), baseUrl: baseUrlWebService),
  );
  locator.registerSingleton<UserApiRepository>(
    UserApiRepositoryImpl(locator<UserApiService>()),
  );

}