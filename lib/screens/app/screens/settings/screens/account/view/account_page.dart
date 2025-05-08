import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/di.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/features/user/network/users_remote_data_source.dart';
import 'package:app/features/user/network/users_repository.dart';
import 'package:app/features/user/use_case/users_update_use_case.dart';
import 'package:app/shared/form_template/i_form_template.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = context.read<UserCubit>().state.userResult!.maybeValue!;
  }

  @override
  Widget build(BuildContext context) {
    return IFormTemplate(
      useCase: UsersUpdateUseCase(
        cockpitRepository: UsersRepository(
          remoteDS: inject<UsersRemoteDataSource>(),
        ),
        resourceId: user.id,
      ),
      fields: [
        IFormTextField(
          name: 'name',
          label: 'Imię',
          placeholder: 'Wpisz imię',
          validators: [
            FormBuilderValidators.required(),
          ],
          initialValue: user.name,
        ),
        IFormTextField(
          name: 'lastname',
          label: 'Nazwisko',
          placeholder: 'Wpisz nazwisko',
          validators: [
            FormBuilderValidators.required(),
          ],
          initialValue: user.lastname,
        ),
        IFormTextField(
          name: 'email',
          label: 'Adres e-mail',
          placeholder: 'Wpisz imię',
          validators: [
            FormBuilderValidators.required(),
          ],
          initialValue: user.email,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
      onSubmit: (resourceId) {},
    );
  }
}
