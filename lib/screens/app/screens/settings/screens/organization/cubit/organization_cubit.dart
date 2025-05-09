import 'package:app/features/organization/network/organization_repository.dart';
import 'package:app/screens/app/screens/settings/screens/organization/cubit/organization_state.dart';
import 'package:app/type_def/json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  OrganizationCubit({
    required this.repository,
  }) : super(const OrganizationState());

  final OrganizationRepository repository;

  Future<bool> updateOrganization(Json payload) async{
    emit(const OrganizationState(isLoading: true));
    final success = await repository.updateOrganization(payload);
    emit(const OrganizationState(isLoading: false));
    return success;
  }
}
