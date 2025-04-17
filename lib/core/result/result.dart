import 'package:app/enums/api_messages.dart';

abstract class Result<T> {
  bool get isSuccess => this is SuccessResult;

  bool get isError => this is ErrorResult;

  T? get maybeValue =>
      this is SuccessResult<T> ? (this as SuccessResult<T>).data : null;

  ApiMessages? get maybeError =>
      this is ErrorResult<T> ? (this as ErrorResult<T>).error : null;
}

class SuccessResult<T> extends Result<T> {
  SuccessResult(this.data);

  final T data;
}

class ErrorResult<T> extends Result<T> {
  ErrorResult(this.error);

  final ApiMessages error;
}
