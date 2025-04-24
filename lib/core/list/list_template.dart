import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:flutter/material.dart';

abstract class ListTemplate<T> extends StatelessWidget{
  const ListTemplate({super.key});

  String? get title => null;

  ListCubit<T> get cubit;

  Widget Function(BuildContext context, ListCubit<T> cubit) get builder;

  Permissions get createPermission;
}
