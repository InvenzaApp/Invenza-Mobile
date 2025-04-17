import 'package:app/core/result/result.dart';
import 'package:app/enums/api_messages.dart';
import 'package:app/type_def/json.dart';

extension ResultExtension<T> on Future<Json> {
  Future<Result<E>> asResult<E>({E Function(Json)? fromJson}) async {
    final result = await then((item) => item);
    final success = result['success'] as bool;
    final data = result['data'];

    if (!success) {
      return ErrorResult(ApiMessages.fromJson(data as String));
    } else {
      if (fromJson != null) {
        return SuccessResult(fromJson(data as Json));
      }else{
        return SuccessResult(data as E);
      }
    }
  }

  Future<Result<List<E>>> asListResult<E>({E Function(Json)? fromJson}) async {
    final result = await then((item) => item);
    final success = result['success'] as bool;
    final data = result['data'];

    if (!success) {
      return ErrorResult(ApiMessages.fromJson(data as String));
    } else {
      if (fromJson != null) {
        final listJson = data as List<dynamic>;
        return SuccessResult(listJson.map((e) => fromJson(e as Json)).toList());
      }else{
        return SuccessResult(data as List<E>);
      }
    }
  }
}
