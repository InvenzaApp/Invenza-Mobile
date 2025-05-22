import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/core/list/cubit/list_state.dart';
import 'package:app/core/list/list_template.dart';
import 'package:app/core/user_permissions/user_permissions.dart';
import 'package:app/enums/permissions.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/shared/widgets/i_list_skeletonizer.dart';
import 'package:app/shared/widgets/i_no_permissions_widget.dart';
import 'package:app/shared/widgets/i_search_bar.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IListTemplate<T extends ItemEntity> extends ListTemplate<T> {
  const IListTemplate({
    required this.cubit,
    required this.widget,
    required this.createPermission,
    required this.listPermission,
    this.showBackButton = true,
    super.key,
  });

  @override
  final Widget Function(BuildContext context, T item) widget;

  @override
  final ListCubit<T> cubit;

  @override
  final Permissions createPermission;

  @override
  final Permissions listPermission;

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        appBar: iAppBar(
          context: context,
          title: cubit.repository.title ?? l10n.list,
          showBackButton: showBackButton,
        ),
        floatingActionButton:
            (!UserPermissions.hasPermission(createPermission) ||
                    cubit.createRoute == null)
                ? null
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () async {
                      final needUpdate =
                          await context.pushRoute(cubit.createRoute!);

                      if (needUpdate == true) {
                        await cubit.initialize();
                      }
                    },
                  ),
        body: !UserPermissions.hasPermission(listPermission)
            ? const INoPermissionsWidget()
            : BlocBuilder<ListCubit<T>, ListState<T>>(
                builder: (context, state) => switch (state.isLoading) {
                  true => const IListSkeletonizer(),
                  false => (state.data?.isError ?? true)
                      ? IErrorWidget(
                          subtitle: state.data!.maybeError!.asString(context),
                          onPressed: () async => cubit.initialize(),
                        )
                      : (state.data?.maybeValue?.isEmpty ?? true)
                          ? IErrorWidget(
                              icon: Icons.cloud_off,
                              title: l10n.empty_list_title,
                              subtitle: l10n.empty_list_subtitle,
                              onPressed: () async =>
                                  context.read<ListCubit<T>>().initialize(),
                            )
                          : Padding(
                              padding: mediumPadding,
                              // child: builder(context, cubit),
                              child: RefreshIndicator(
                                onRefresh: () async =>
                                    context.read<ListCubit<T>>().initialize(),
                                child: ListView.builder(
                                  itemCount: state.isSearching
                                      ? state.filteredData.length + 1
                                      : state.data!.maybeValue!.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Column(
                                        children: [
                                          ISearchBar(
                                            onChanged: (query) {
                                              context
                                                  .read<ListCubit<T>>()
                                                  .onSearch(
                                                    query,
                                                  );
                                            },
                                          ),
                                          SizedBox(height: mediumValue),
                                        ],
                                      );
                                    }

                                    if (state.filteredData.isNotEmpty) {
                                      final item =
                                          state.filteredData[index - 1];

                                      return Column(
                                        children: [
                                          widget(context, item),
                                          SizedBox(height: smallValue),
                                        ],
                                      );
                                    }

                                    final item =
                                        state.data!.maybeValue![index - 1];

                                    return Column(
                                      children: [
                                        widget(context, item),
                                        SizedBox(height: smallValue),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                },
              ),
      ),
    );
  }
}
