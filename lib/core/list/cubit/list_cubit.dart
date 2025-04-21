import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/list/cubit/list_state.dart';
import 'package:app/core/result/result.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ListCubit<T> extends Cubit<ListState<T>> {
  ListCubit({this.createRoute}) : super(ListState<T>()) {
    initialize();
  }

  CockpitRepository get repository;

  Future<void> initialize();

  final PageRouteInfo? createRoute;

  void emitState({
    Result<List<T>>? data,
    bool? isLoading,
  }) =>
      super.emit(state.copyWith(data: data, isLoading: isLoading));

  List<T> get data => super.state.data!.maybeValue!;
}
