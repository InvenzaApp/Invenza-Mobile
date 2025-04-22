import 'package:app/core/result/result.dart';
import 'package:equatable/equatable.dart';

class ListState<T> extends Equatable {
  const ListState({
    this.data,
    this.isLoading = false,
  });

  ListState<T> copyWith({
    Result<List<T>>? data,
    bool? isLoading,
  }) {
    return ListState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final Result<List<T>>? data;
  final bool isLoading;

  @override
  List<Object?> get props => [data, isLoading];
}
