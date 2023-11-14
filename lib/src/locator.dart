import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/gyro_info_api_service.dart';
import 'data/datasources/remote/heart_info_api_service.dart';
import 'data/datasources/remote/illness_api_service.dart';
import 'data/datasources/remote/relationship_api_service.dart';
import 'data/datasources/remote/user_api_service.dart';
import 'data/datasources/remote/user_data_api_service.dart';
import 'data/datasources/remote/user_patient_api_service.dart';
import 'data/repositories/gyro_info_api_repository_impl.dart';
import 'data/repositories/heart_info_api_repository_impl.dart';
import 'data/repositories/illness_api_repository_impl.dart';
import 'data/repositories/relationship_api_repository_impl.dart';
import 'data/repositories/user_api_repository_impl.dart';
import 'data/repositories/user_data_api_repository_impl.dart';
import 'data/repositories/user_patient_api_repository_impl.dart';
import 'domain/repositories/gyro_info_api_repository.dart';
import 'domain/repositories/heart_info_api_repository.dart';
import 'domain/repositories/illness_api_repository.dart';
import 'domain/repositories/relationship_api_repository.dart';
import 'domain/repositories/user_api_repository.dart';
import 'domain/repositories/user_data_api_repository.dart';
import 'domain/repositories/user_patient_api_repository.dart';

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

  //User
  locator.registerSingleton<UserApiService>(
    UserApiService(locator<Dio>(), baseUrl: baseUrlWebService),
  );
  locator.registerSingleton<UserApiRepository>(
    UserApiRepositoryImpl(locator<UserApiService>()),
  );

  //User Data
  locator.registerSingleton<UserDataApiService>(
    UserDataApiService(locator<Dio>(), baseUrl: baseUrlWebService),
  );
  locator.registerSingleton<UserDataApiRepository>(
    UserDataApiRepositoryImpl(locator<UserDataApiService>()),
  );

  //User Patient
  locator.registerSingleton<UserPatientApiService>(
    UserPatientApiService(locator<Dio>(), baseUrl: baseUrlWebService),
  );
  locator.registerSingleton<UserPatientApiRepository>(
    UserPatientApiRepositoryImpl(locator<UserPatientApiService>()),
  );

  //Gyro Info
  locator.registerSingleton<GyroInfoApiService>(
    GyroInfoApiService(locator<Dio>(), baseUrl: baseUrlWebService),
  );
  locator.registerSingleton<GyroInfoApiRepository>(
    GyroInfoApiRepositoryImpl(locator<GyroInfoApiService>()),
  );

  //Heart Info
  locator.registerSingleton<HeartInfoApiService>(
    HeartInfoApiService(locator<Dio>(), baseUrl: baseUrlWebService),
  );
  locator.registerSingleton<HeartInfoApiRepository>(
    HeartInfoApiRepositoryImpl(locator<HeartInfoApiService>()),
  );

}