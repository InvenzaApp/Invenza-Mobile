import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:flutter/material.dart';

abstract class ShowTemplate<T> extends StatefulWidget{
  const ShowTemplate({super.key});

  ShowCubit<T> get cubit;

  Widget Function(BuildContext context, ShowCubit<T> cubit) get builder;

  bool get deleteEnabled;

  bool get editEnabled;

  Permissions get updatePermission;

  Permissions get deletePermission;
}
