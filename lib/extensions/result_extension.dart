import 'package:app/core/result/result.dart';
import 'package:app/enums/api_messages.dart';
import 'package:app/type_def/json.dart';

extension ResultExtension<T> on Json {
  Result<E> asResult<E>(E Function(Json) fromJson) {
      final success = this['success'] as bool? ?? false;
      if (!success) {
        final errorData = this['data'];
        return ResultError(ApiMessages.fromJson(errorData.toString()));
      }

      final resultData = this['data'];
      if (resultData is! Json) {
        return ResultError(ApiMessages.invalidRequestParameters);
      }

      return ResultSuccess(fromJson(resultData));
  }
}
