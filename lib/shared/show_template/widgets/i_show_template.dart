import 'dart:async';

import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/core/show/cubit/show_state.dart';
import 'package:app/core/show/show_template.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/shared/widgets/i_show_skeletonizer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IShowTemplate<T> extends ShowTemplate<T> {
  const IShowTemplate({
    required this.cubit,
    required this.builder,
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
}

class _IShowTemplateState<T> extends State<IShowTemplate<T>> {
  bool requireUpdate = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => widget.cubit,
      child: Scaffold(
        appBar: iAppBar(
          context: context,
          title: widget.cubit.repository.title ?? context.l10n.preview,
          backButtonAction: () {
            context.maybePop(requireUpdate);
          },
          actions: [
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
          ],
        ),
        floatingActionButton:
            (widget.cubit.editRoute == null || !widget.editEnabled)
                ? null
                : FloatingActionButton(
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
                  ),
        body: BlocBuilder<ShowCubit<T>, ShowState<T>>(
          builder: (context, state) => switch (state.isLoading) {
            true => const IShowSkeletonizer(),
            false => (state.data?.isError ?? true)
                ? IErrorWidget(
              subtitle: state.data!.maybeError!.asString(context),
            )
                : widget.builder(context, widget.cubit),
          },
        ),
      ),
    );
  }
}
