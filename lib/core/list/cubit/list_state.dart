import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/result/result.dart';
import 'package:equatable/equatable.dart';

class ListState<T extends ItemEntity> extends Equatable {
  const ListState({
    this.data,
    this.filteredData = const [],
    this.isLoading = false,
    this.isSearching = false,
  });

  ListState<T> copyWith({
    Result<List<T>>? data,
    bool? isLoading,
    List<T>? filteredData,
    bool? isSearching,
  }) {
    return ListState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      filteredData: filteredData ?? this.filteredData,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  final Result<List<T>>? data;
  final bool isLoading;
  final List<T> filteredData;
  final bool isSearching;

  @override
  List<Object?> get props => [data, isLoading, filteredData, isSearching];
}
