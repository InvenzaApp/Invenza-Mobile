import 'package:app/core/cockpit_repo/cockpit_repo.dart';
import 'package:app/di.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/screens/app/screens/tasks/screens/form/create/repo/tasks_remote_data_source.dart';
import 'package:app/screens/app/screens/tasks/screens/form/create/repo/tasks_repository.dart';
import 'package:app/screens/app/screens/tasks/screens/form/create/use_case/tasks_create_use_case.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/variables.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@RoutePage()
class TasksFormPage extends StatelessWidget {
  const TasksFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IFormWidget(
      repo: TasksRepository(
        title: 'Zadania',
        remoteDS: inject<TasksRemoteDataSource>(),
        useCase: inject<TasksCreateUseCase>(),
      ),
      fields: [
        FormBuilderTextField(
          name: 'name',
        ),
      ],
    );
  }
}

class IFormWidget extends StatelessWidget {
  const IFormWidget({
    required this.repo,
    required this.fields,
    super.key,
  });

  final CockpitRepo repo;
  final List<Widget> fields;

  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: repo.title,
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
                    children: fields,
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
              label: repo.useCase is CreateUseCase ? 'Create' : 'Update',
              onPressed: () async {
                if(_formKey.currentState!.saveAndValidate()){
                  await repo.useCase.invoke(_formKey.currentState!.value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
