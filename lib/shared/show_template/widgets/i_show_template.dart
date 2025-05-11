import 'dart:async';

import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/core/show/cubit/show_state.dart';
import 'package:app/core/show/show_template.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/shared/widgets/i_show_skeletonizer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IShowTemplate<T extends ItemEntity> extends ShowTemplate<T> {
  const IShowTemplate({
    required this.cubit,
    required this.builder,
    required this.updatePermission,
    required this.deletePermission,
    this.deleteEnabled = true,
    this.editEnabled = true,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _IShowTemplateState<T>();

  @override
  final ShowCubit<T> cubit;

  @override
  final Widget Function(BuildContext context, ShowCubit<T> cubit) builder;

  @override
  final bool deleteEnabled;

  @override
  final bool editEnabled;

  @override
  final Permissions deletePermission;

  @override
  final Permissions updatePermission;
}

class _IShowTemplateState<T extends ItemEntity>
    extends State<IShowTemplate<T>> {
  bool requireUpdate = false;

  bool canDeleteGetter(ShowState<T> state, UserCubit cubit) {
    if(state.data?.isError ?? true) return false;
    if(!UserPermissions.hasPermission(widget.deletePermission)) return false;
    if(cubit.state.userResult?.maybeValue?.admin ?? false) return true;
    if(state.data?.maybeValue?.locked ?? true) return false;

    return true;
  }

  bool canEditGetter(ShowState<T> state, UserCubit cubit){
    if(state.data?.isError ?? true) return false;
    if(widget.cubit.editRoute == null) return false;
    if(!widget.editEnabled) return false;
    if(!UserPermissions.hasPermission(widget.updatePermission)) return false;
    if(cubit.state.userResult?.maybeValue?.admin ?? false) return true;
    if(state.data?.maybeValue?.locked ?? true) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => widget.cubit,
      child: BlocBuilder<ShowCubit<T>, ShowState<T>>(
        builder: (context, state) {
          final canDelete = canDeleteGetter(state, context.read<UserCubit>());
          final canEdit = canEditGetter(state, context.read<UserCubit>());

          return Scaffold(
            appBar: iAppBar(
              context: context,
              title: widget.cubit.repository.title ?? context.l10n.preview,
              backButtonAction: () {
                context.maybePop(requireUpdate);
              },
              actions: canDelete
                  ? [
                      if (widget.deleteEnabled)
                        IconButton(
                          icon: Icon(Icons.delete, color: context.error),
                          onPressed: () async {
                            final needUpdate =
                                await context.showConfirm(l10n.delete_confirm);

                            if (needUpdate != null && needUpdate) {
                              unawaited(widget.cubit.delete());
                              if (context.mounted) {
                                await context.maybePop(true);
                              }
                            }
                          },
                        ),
                    ]
                  : null,
            ),
            floatingActionButton: canEdit
                ? FloatingActionButton(
                    child: const Icon(Icons.edit),
                    onPressed: () async {
                      final needUpdate =
                          await context.pushRoute(widget.cubit.editRoute!);

                      if (needUpdate == true) {
                        setState(() {
                          requireUpdate = true;
                        });
                        await widget.cubit.initialize();
                      }
                    },
                  )
                : null,
            body: switch (state.isLoading) {
              true => const IShowSkeletonizer(),
              false => (state.data?.isError ?? true)
                  ? IErrorWidget(
                      subtitle: state.data!.maybeError!.asString(context),
                      onPressed: () async => widget.cubit.initialize(),
                    )
                  : widget.builder(context, widget.cubit),
            },
          );
        },
      ),
    );
  }
}
