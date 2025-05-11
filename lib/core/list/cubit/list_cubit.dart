import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/list/cubit/list_state.dart';
import 'package:app/core/result/result.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ListCubit<T extends ItemEntity> extends Cubit<ListState<T>> {
  ListCubit({this.createRoute}) : super(ListState<T>()) {
    initialize();
  }

  CockpitRepository get repository;

  Future<void> initialize();

  final PageRouteInfo? createRoute;

  void emitState({
    Result<List<T>>? data,
    bool? isLoading,
    List<T>? filteredData,
    bool? isSearching,
  }) =>
      super.emit(
        state.copyWith(
          data: data,
          isLoading: isLoading,
          filteredData: filteredData,
          isSearching: isSearching,
        ),
      );

  List<T> get data => super.state.data?.maybeValue ?? [];

  void onSearch(String query) {
    final data = state.data?.maybeValue;

    if (query == '') {
      emitState(filteredData: [], isSearching: false);
      return;
    }

    final filteredData = data!
        .where(
          (e) => e.title.trim().toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    emitState(filteredData: filteredData, isSearching: true);
  }
}
