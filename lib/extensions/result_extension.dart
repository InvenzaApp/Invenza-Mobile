import 'package:app/core/result/result.dart';
import 'package:app/enums/api_messages.dart';
import 'package:app/type_def/json.dart';
import 'package:dio/dio.dart';

extension ResultExtension<T> on Future<Response<Json>> {
  Future<Result<E>> asResult<E>({E Function(Json)? fromJson}) async {
    final result = await then((res) => res.data!)
        .then((item) => item)
        .catchError((Object e) => {'error': e});

    if(result['error'] != null){
      return ErrorResult(ApiMessages.unknownError);
    }

    final success = result['success'] as bool;
    final data = result['data'];

    if (!success) {
      return ErrorResult(ApiMessages.fromJson(data as String));
    } else {
      if (fromJson != null) {
        return SuccessResult(fromJson(data as Json));
      } else {
        return SuccessResult(data as E);
      }
    }
  }

  Future<Result<List<E>>> asListResult<E>({E Function(Json)? fromJson}) async {
    final result = await then((res) => res.data!)
        .then((item) => item)
        .catchError((Object e) => {'error': e});

    if(result['error'] != null){
      return ErrorResult(ApiMessages.unknownError);
    }

    final success = result['success'] as bool;
    final data = result['data'];

    if (!success) {
      return ErrorResult(ApiMessages.fromJson(data as String));
    } else {
      if (fromJson != null) {
        final listJson = data as List<dynamic>;
        return SuccessResult(listJson.map((e) => fromJson(e as Json)).toList());
      } else {
        return SuccessResult(data as List<E>);
      }
    }
  }
}

extension AuthResultExtension<T> on Future<Json> {
  Future<Result<E>> asResult<E>({E Function(Json)? fromJson}) async {
    final result = await then((item) => item);

    final success = result['success'] as bool;
    final data = result['data'];

    if (!success) {
      return ErrorResult(ApiMessages.fromJson(data as String));
    } else {
      if (fromJson != null) {
        return SuccessResult(fromJson(data as Json));
      } else {
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
        final dataList = (data as List<dynamic>).map((item){
          return fromJson(item as Json);
        }).toList();
        return SuccessResult(dataList);
      } else {
        return SuccessResult(data as List<E>);
      }
    }
  }
}
