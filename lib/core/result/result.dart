import 'package:app/enums/api_messages.dart';

class Result<T> {
  ResultSuccess<T>? get maybeValue =>
      this is ResultSuccess<T> ? this as ResultSuccess<T> : null;

  ResultError<T>? get maybeError =>
      this is ResultError<T> ? this as ResultError<T> : null;

  bool isSuccess() => this is ResultSuccess;

  bool isError() => this is ResultError;
}

class ResultSuccess<T> extends Result<T> {
  ResultSuccess(this.data);

  final T data;
}

class ResultError<T> extends Result<T> {
  ResultError(this.errorMessage);

  final ApiMessages errorMessage;
}
