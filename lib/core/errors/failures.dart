// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;

  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is int || statusCode is String,
          'Status code cannot be a ${statusCode.runtimeType}',
        );
  @override
  List<dynamic> get props => [message, statusCode];

  @override
  bool get stringify => true;
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}
