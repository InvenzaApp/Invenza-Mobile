import 'package:equatable/equatable.dart';

class ICardItem extends Equatable {
  const ICardItem({
    required this.value,
    this.label,
  });

  final String? label;
  final String value;

  @override
  List<Object?> get props => [label, value];
}
