import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/result/result.dart';
import 'package:equatable/equatable.dart';

class SelectState<T extends ItemEntity> extends Equatable {
  const SelectState({
    this.isLoading = false,
    this.data,
  });

  final bool isLoading;
  final Result<List<T>>? data;

  @override
  List<Object?> get props => [isLoading, data];
}
