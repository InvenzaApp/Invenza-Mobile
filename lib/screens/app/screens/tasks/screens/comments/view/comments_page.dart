import 'package:app/di.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/features/comment/network/comments_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/cubit/comments_cubit.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/cubit/comments_state.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/widgets/comment_widget.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/widgets/comments_message_input.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/widgets/comments_skeletonizer.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_error_widget.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CommentsPage extends StatelessWidget implements AutoRouteWrapper {
  const CommentsPage({required this.taskId, super.key});

  final int taskId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => CommentsCubit(
        repository: inject<CommentsRepository>(),
        taskId: taskId,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: context.l10n.comments_app_bar,
      ),
      body: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CommentsSkeletonizer();
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      context.read<CommentsCubit>().fetchComments(),
                  child: ListView.builder(
                    itemCount:
                        state.comments.isEmpty ? 1 : state.comments.length,
                    itemBuilder: (context, index) {
                      if (state.comments.isEmpty) {
                        return IErrorWidget(
                          icon: Icons.messenger_outline,
                          title: context.l10n.comments_not_found,
                          showSubtitle: false,
                        );
                      }

                      final comment = state.comments[index];

                      return Column(
                        children: [
                          Padding(
                            padding: mediumHorizontalPadding,
                            child: CommentWidget(comment: comment),
                          ),
                          SizedBox(height: mediumValue),
                        ],
                      );
                    },
                  ),
                ),
              ),
              CommentsMessageInput(
                taskId: taskId,
              ),
            ],
          );
        },
      ),
    );
  }
}
