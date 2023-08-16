import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/illness.dart';

abstract class IllnessState extends Equatable {
  final List<Illness> illnesses;
  final DioException? error;

  const IllnessState({
    this.illnesses = const [],
    this.error
  });

  @override
  List<Object?> get props => [illnesses, error];
}

class IllnessLoading extends IllnessState {
  const IllnessLoading();
}

class IllnessSuccess extends IllnessState {
  const IllnessSuccess({super.illnesses});
}

class IllnessFailed extends IllnessState {
  const IllnessFailed({super.error});
}