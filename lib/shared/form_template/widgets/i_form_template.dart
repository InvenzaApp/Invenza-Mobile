import 'package:app/core/result/result.dart';
import 'package:app/core/use_case/use_case.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/extensions/toast_extension.dart';
import 'package:app/shared/form_template/models/i_form_widget.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/shared/widgets/one_ui_scroll_view.dart';
import 'package:app/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IFormTemplate extends StatefulWidget {
  const IFormTemplate({
    required this.useCase,
    required this.fields,
    required this.onSubmit,
    this.appbarTitle,
    super.key,
  });

  final UseCase useCase;
  final List<IFormWidget> fields;
  final String? appbarTitle;
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
      body: OneUIScrollView(
        title: widget.appbarTitle ??
            widget.useCase.cockpitRepository.title ??
            l10n.form,
        subtitle: l10n.form,
        slivers: [
          SliverToBoxAdapter(
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
        ],
      ),
      bottomNavigationBar: Container(
        padding: largePadding,
        decoration: BoxDecoration(
          color: context.container,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IButton(
              isPending: isLoading,
              label:
                  widget.useCase is CreateUseCase ? l10n.create : l10n.update,
              onPressed: () async {
                if (_formKey.currentState!.saveAndValidate()) {
                  setState(() {
                    isLoading = true;
                  });

                  final payload = _formKey.currentState!.value;

                  final result = await widget.useCase.invoke(payload);

                  setState(() {
                    isLoading = false;
                  });

                  if (!context.mounted) return;

                  if (result.isError) {
                    final error = result.maybeError!;
                    context.showToast(error.asString(context));
                  }

                  if (result.isSuccess) {
                    widget.onSubmit(result);
                  }
                }
              },
            ),
            SizedBox(height: mediumValue),
          ],
        ),
      ),
    );
  }
}
