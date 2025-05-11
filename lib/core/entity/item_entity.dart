import 'package:app/core/entity/entity.dart';

abstract class ItemEntity extends Entity{
  @override
  int get id;
  @override
  String get title;
  bool get locked;
}
