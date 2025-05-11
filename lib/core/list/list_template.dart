import 'package:app/core/entity/item_entity.dart';
import 'package:app/core/list/cubit/list_cubit.dart';
import 'package:app/enums/permissions.dart';
import 'package:flutter/material.dart';

abstract class ListTemplate<T extends ItemEntity> extends StatelessWidget{
  const ListTemplate({super.key});

  String? get title => null;

  ListCubit<T> get cubit;

  Widget Function(BuildContext context, T item) get widget;

  Permissions get createPermission;

  Permissions get listPermission;
}
