import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/shared/form_template/models/i_form_widget.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormTemplate extends StatefulWidget {
  const IFormTemplate({
    required this.useCase,
    required this.fields,
    required this.onSubmit,
    super.key,
  });

  final UseCase useCase;
  final List<IFormWidget> fields;
  final void Function(Result<int> resourceId) onSubmit;

  @override
  State<IFormTemplate> createState() => _IFormTemplateState();
}

class _IFormTemplateState extends State<IFormTemplate> {
  static final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: widget.useCase.cockpitRepository.title ?? l10n.form,
      ),
      body: Column(
        children: [
          Expanded(
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: largePadding,
                  child: Column(
                    spacing: largeValue,
                    children: widget.fields,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: largePadding,
            decoration: BoxDecoration(
              color: context.container,
            ),
            child: IButton(
              isPending: isLoading,
              label:
                  widget.useCase is CreateUseCase ? l10n.create : l10n.update,
              onPressed: () async {
                if (_formKey.currentState!.saveAndValidate()) {
                  setState(() {
                    isLoading = true;
                  });

                  final taskId = await widget.useCase.invoke(
                    _formKey.currentState!.value,
                  );

                  setState(() {
                    isLoading = false;
                  });

                  widget.onSubmit(taskId);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
