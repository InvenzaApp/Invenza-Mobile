import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/result/result.dart';
import 'package:app/core/select/select_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCubit<T extends ItemEntity> extends Cubit<SelectState<T>> {
  SelectCubit({
    required this.repository,
  }) : super(const SelectState()) {
    fetch();
  }

  final CockpitRepository repository;

  Future<void> fetch() async {
    emit(SelectState(isLoading: true));
    final result = (await repository.getAll()) as Result<List<T>>;
    emit(SelectState(data: result));
  }
}
