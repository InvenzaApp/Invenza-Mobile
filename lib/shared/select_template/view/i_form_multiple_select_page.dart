import 'package:app/core/cockpit_repository/cockpit_repository.dart';
import 'package:app/core/entity/entity.dart';
import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/select/select_cubit.dart';
import 'package:app/core/select/select_state.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/shared/widgets/i_form_skeletonizer.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IFormMultipleSelectPage<T extends ItemEntity> extends StatefulWidget {
  const IFormMultipleSelectPage({
    required this.repository,
    required this.name,
    this.initialIdList,
    this.dontBuildWithId,
    super.key,
  });

  final CockpitRepository repository;
  final String name;
  final List<int>? initialIdList;
  final int? dontBuildWithId;

  @override
  State<IFormMultipleSelectPage> createState() =>
      _IFormMultipleSelectPageState<T>();
}

class _IFormMultipleSelectPageState<T extends ItemEntity>
    extends State<IFormMultipleSelectPage> {
  List<int> selectedEntities = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialIdList?.isNotEmpty ?? false) {
      setState(() {
        selectedEntities = widget.initialIdList!;
      });
    }
  }

  void onSelectAll(SelectState<T> state, User user) {
    setState(() {
      selectedEntities = state.data!.maybeValue!
          .where((e) {
            if (user.admin) {
              return true;
            } else {
              return !e.locked;
            }
          })
          .map((e) => e.id)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final user = context.read<UserCubit>().state.userResult!.maybeValue!;

    return BlocProvider(
      create: (_) => SelectCubit<T>(repository: widget.repository),
      child: BlocBuilder<SelectCubit<T>, SelectState<T>>(
        builder: (context, state) {
          return Scaffold(
            appBar: iAppBar(
              context: context,
              title: l10n.select,
            ),
            body: switch (state.isLoading) {
              true => const IFormSkeletonizer(
                  showAppBar: false,
                ),
              false => (state.data?.isError ?? true)
                  ? IErrorWidget(
                      onPressed: () async =>
                          context.read<SelectCubit<T>>().fetch(),
                    )
                  : (state.data?.maybeValue?.isEmpty ?? true)
                      ? IErrorWidget(
                          icon: Icons.cloud_off,
                          title: l10n.empty_list_title,
                          subtitle: l10n.empty_list_subtitle,
                          onPressed: () async =>
                              context.read<SelectCubit<T>>().fetch(),
                        )
                      : Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: context.surface,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () => onSelectAll(state, user),
                                    child: Text(l10n.selectAll),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedEntities = [];
                                      });
                                    },
                                    child: Text(l10n.unselectAll),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: mediumPadding,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.data!.maybeValue!.length,
                                  itemBuilder: (context, index) {
                                    final data = state.data!.maybeValue![index];

                                    if (!user.admin && data.locked) {
                                      return const SizedBox.shrink();
                                    }

                                    if (widget.dontBuildWithId != null &&
                                        data.id == widget.dontBuildWithId) {
                                      return const SizedBox.shrink();
                                    }

                                    return Column(
                                      children: [
                                        _IFormMultipleSelectWidget(
                                          isSelected: selectedEntities
                                              .contains(data.id),
                                          entity: data,
                                          onChanged: (selected) {
                                            setState(() {
                                              if (selectedEntities
                                                  .contains(data.id)) {
                                                selectedEntities
                                                    .remove(data.id);
                                              } else {
                                                selectedEntities.add(data.id);
                                              }
                                            });
                                          },
                                        ),
                                        SizedBox(height: mediumValue),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: largePadding,
                              decoration: BoxDecoration(
                                color: context.container,
                              ),
                              child: Column(
                                children: [
                                  IButton(
                                    label: l10n.save,
                                    onPressed: () {
                                      if (selectedEntities.isEmpty) {
                                        context.maybePop(<Entity>[]);
                                      } else {
                                        context.maybePop(selectedEntities);
                                      }
                                    },
                                  ),
                                  SizedBox(height: mediumValue),
                                ],
                              ),
                            ),
                          ],
                        ),
            },
          );
        },
      ),
    );
  }
}

class _IFormMultipleSelectWidget extends StatelessWidget {
  const _IFormMultipleSelectWidget({
    required this.isSelected,
    required this.entity,
    required this.onChanged,
  });

  final bool isSelected;
  final Entity entity;
  final void Function(bool selected) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isSelected),
      borderRadius: BorderRadius.circular(mediumValue),
      child: Ink(
        padding: xLargePadding,
        decoration: BoxDecoration(
          color: isSelected ? context.primaryContainer : context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          spacing: mediumValue,
          children: [
            Icon(isSelected ? Icons.check_circle : Icons.circle_outlined),
            Expanded(
              child: Text(
                entity.title,
                style: context.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
