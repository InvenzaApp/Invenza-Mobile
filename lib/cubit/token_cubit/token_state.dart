import 'package:equatable/equatable.dart';

class TokenState extends Equatable {
  const TokenState({this.token});

  final String? token;

  @override
  List<Object?> get props => [token];
}
