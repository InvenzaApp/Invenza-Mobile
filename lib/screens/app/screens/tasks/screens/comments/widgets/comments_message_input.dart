import 'dart:async';

import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/screens/app/screens/tasks/screens/comments/cubit/comments_cubit.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CommentsMessageInput extends StatelessWidget {
  const CommentsMessageInput({required this.taskId, super.key});

  static final _formKey = GlobalKey<FormBuilderState>();

  final int taskId;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Container(
        padding: mediumPadding,
        decoration: BoxDecoration(
          color: context.container,
        ),
        child: Column(
          children: [
            Row(
              spacing: mediumValue,
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'title',
                    decoration: InputDecoration(
                      hintText: context.l10n.comments_input_placeholder,
                      filled: true,
                      fillColor: context.surface,
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    validator: FormBuilderValidators.required(),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (_formKey.currentState!.saveAndValidate()) {
                      final commentsCubit = context.read<CommentsCubit>();
                      final data = _formKey.currentState!.value;
                      final payload = {...data};
                      payload['taskId'] = taskId;

                      final success = await commentsCubit.postComment(payload);

                      if (success) {
                        _formKey.currentState?.fields['title']?.reset();
                        FocusManager.instance.primaryFocus?.unfocus();
                        unawaited(commentsCubit.fetchComments());
                      }
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
            SizedBox(height: largeValue),
          ],
        ),
      ),
    );
  }
}
