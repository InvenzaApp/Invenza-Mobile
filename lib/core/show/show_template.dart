import 'package:app/core/show/cubit/show_cubit.dart';
import 'package:flutter/material.dart';

abstract class ShowTemplate<T> extends StatefulWidget{
  const ShowTemplate({super.key});

  String? get title => null;

  ShowCubit<T> get cubit;

  Widget Function(BuildContext context, ShowCubit<T> cubit) get builder;
}
