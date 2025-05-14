import 'package:app/core/entity/item_entity.dart';
import 'package:app/features/user/models/user.dart';
import 'package:app/type_def/json.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(createToJson: false)
class Event extends ItemEntity with EquatableMixin {
  Event({
    required this.id,
    required this.title,
    required this.dateFrom,
    required this.dateTo,
    required this.author,
    required this.locked,
    this.description,
  });

  factory Event.fromJson(Json json) => _$EventFromJson(json);

  @override
  final int id;
  @override
  final String title;
  final String? description;
  final User author;
  final DateTime dateFrom;
  final DateTime dateTo;
  @override
  final bool locked;

  @override
  List<Object?> get props => [
        id,
        title,
        dateFrom,
        dateTo,
        description,
        author,
        locked,
      ];
}
