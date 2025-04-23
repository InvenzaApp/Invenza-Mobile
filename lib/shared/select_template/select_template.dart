import 'package:app/app/routing/app_router.gr.dart';
import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/result/result.dart';
import 'package:app/di.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/group/models/group.dart';
import 'package:app/features/group/network/groups_remote_data_source.dart';
import 'package:app/features/group/network/groups_repository.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/shared/widgets/i_form_skeletonizer.dart';
import 'package:app/variables.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IFormMultipleSelectWidget<T> extends IFormStatelessWidget {
  const IFormMultipleSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grupy',
          style: context.bodyMedium,
        ),
        InkWell(
          onTap: () {
            context.router.pushWidget(
              IFormMultipleSelectPage<Group>(
                repository: GroupsRepository(
                  remoteDS: inject<GroupsRemoteDataSource>(),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(mediumValue),
          child: Ink(
            padding: mediumPadding,
            decoration: BoxDecoration(
              color: context.container,
              borderRadius: mediumRadius,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wybierz grupy',
                      style: context.titleSmall,
                    ),
                    Text(
                      'Naciśnij, aby wybrać elementy',
                      style: context.bodyMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class IFormMultipleSelectPage<T> extends StatelessWidget {
  const IFormMultipleSelectPage({
    required this.repository,
    // required this.builder,
    super.key,
  });

  final CockpitRepository repository;
  // final Widget Function(BuildContext context, SelectState<T> state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectCubit<T>(repository: repository),
      child: BlocBuilder<SelectCubit<T>, SelectState<T>>(
        builder: (context, state) {
          return Scaffold(
              appBar: iAppBar(context: context, title: 'Wybierz'),
              body: switch(state.isLoading){
                true => const IFormSkeletonizer(),
                false =>
                (state.data?.isError ?? true)
                    ? const IErrorWidget()
                    : Text('chuj'),
                    // : builder(context, state),
              }
            // Column(
            //   children: [
            //     Expanded(
            //       child: Column(),
            //     ),
            //     Container(
            //       padding: largePadding,
            //       decoration: BoxDecoration(
            //         color: context.container,
            //       ),
            //       child: Column(
            //         children: [
            //           IButton(
            //             label: 'Zapisz',
            //             onPressed: () {},
            //           ),
            //           SizedBox(height: mediumValue),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}

class SelectState<T> extends Equatable {
  const SelectState({
    this.isLoading = false,
    this.data,
  });

  final bool isLoading;
  final Result<List<T>>? data;

  @override
  List<Object?> get props => [isLoading, data];
}

class SelectCubit<T> extends Cubit<SelectState<T>> {
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
