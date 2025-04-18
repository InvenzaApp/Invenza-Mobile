import 'package:app/cubit/token_cubit/token_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenCubit extends Cubit<TokenState>{
  TokenCubit() : super(const TokenState());

  String get token => state.token!;

  set token(String token){
    emit(TokenState(token: token));
  }
}
