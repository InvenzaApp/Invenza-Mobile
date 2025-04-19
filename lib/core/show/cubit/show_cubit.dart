import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/core/show/cubit/show_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ShowCubit<T> extends Cubit<ShowState<T>> {
  ShowCubit({required this.editRoute}) : super(ShowState<T>()) {
    initialize();
  }

  CockpitRepository get repository;

  int get resourceId;

  Future<void> initialize();

  final PageRouteInfo editRoute;

  void emitState({
    Result<T>? data,
    bool? isLoading,
  }) =>
      super.emit(state.copyWith(data: data, isLoading: isLoading));

  T get data => super.state.data!.maybeValue!;
}
