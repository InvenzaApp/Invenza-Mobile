import 'package:app/core/result/result.dart';
import 'package:equatable/equatable.dart';

class ShowState<T> extends Equatable {
  const ShowState({
    this.data,
    this.isLoading = false,
  });

  ShowState<T> copyWith({
    Result<T>? data,
    bool? isLoading,
  }) {
    return ShowState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final Result<T>? data;
  final bool isLoading;

  @override
  List<Object?> get props => [data, isLoading];
}
