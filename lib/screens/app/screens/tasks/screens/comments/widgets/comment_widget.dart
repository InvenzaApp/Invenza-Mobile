import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/confirm_extension.dart';
import 'package:app/extensions/date_time_extension.dart';
import 'package:app/extensions/text_extension.dart';
import 'package:app/features/comment/models/comment.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/cubit/comments_cubit.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({required this.comment, super.key});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    if (comment.author == null) return const SizedBox.shrink();
    final user = context.read<UserCubit>().state.userResult!.maybeValue!;

    return InkWell(
      borderRadius: BorderRadius.circular(mediumValue),
      onLongPress: (user.id != comment.author!.id || comment.deleted)
          ? null
          : () async {
              final commentsCubit = context.read<CommentsCubit>();
              final success =
                  await context.showConfirm(context.l10n.delete_confirm);

              if (success != null && success) {
                await commentsCubit.deleteComment(comment.id);

                if (!context.mounted) return;
                await commentsCubit.fetchComments();
              }
            },
      child: Ink(
        padding: smallPadding,
        decoration: BoxDecoration(
          color: context.container,
          borderRadius: mediumRadius,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    spacing: smallValue,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: largeValue,
                      ),
                      Text(
                        comment.author!.title,
                        style: context.titleSmall.copyWith(
                          decoration: comment.deleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    comment.publishDate.formattedDateTime(context),
                    style: context.bodySmall,
                  ),
                  Text(
                    comment.deleted
                        ? context.l10n.comments_deleted
                        : comment.title,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
