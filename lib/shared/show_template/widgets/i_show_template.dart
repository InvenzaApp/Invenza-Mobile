import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/core/show/cubit/show_state.dart';
import 'package:app/core/show/show_template.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/shared/widgets/i_loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IShowTemplate<T> extends ShowTemplate<T> {
  const IShowTemplate({
    required this.cubit,
    required this.builder,
    this.title,
    super.key,
  });

  @override
  final String? title;

  @override
  State<StatefulWidget> createState() => _IShowTemplateState<T>();

  @override
  final ShowCubit<T> cubit;

  @override
  final Widget Function(BuildContext context, ShowCubit<T> cubit) builder;
}

class _IShowTemplateState<T>
    extends State<IShowTemplate<T>> {
  bool requireUpdate = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.cubit,
      child: Scaffold(
        appBar: iAppBar(
          context: context,
          title: widget.title ?? context.l10n.preview,
          backButtonAction: (){
            context.maybePop(requireUpdate);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () async {
            final needUpdate = await context.pushRoute(widget.cubit.editRoute);

            if(needUpdate == true){
              setState(() {
                requireUpdate = true;
              });
              await widget.cubit.initialize();
            }
          },
        ),
        body: BlocBuilder<ShowCubit<T>, ShowState<T>>(
          builder: (context, state) => switch (state.isLoading) {
            true => const ILoadingWidget(),
            false => (state.data?.isError ?? true)
                ? const IErrorWidget()
                : widget.builder(context, widget.cubit),
          },
        ),
      ),
    );
  }
}
