import 'package:equatable/equatable.dart';

class IFormOption<T> extends Equatable {
  const IFormOption({
    required this.label,
    required this.value,
  });

  final String label;
  final T value;

  @override
  List<Object?> get props => [label, value];
}
