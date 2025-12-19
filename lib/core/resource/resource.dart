import '../error/exceptions.dart';

sealed class Resource<T> {
  final T? data;
  final String? message;

  const Resource({this.data, this.message});

  R? foldOrNull<R>({
    R Function(T data)? onSuccess,
    R Function(String message, dynamic errorData)? onFailure,
    R Function()? onLoading,
    R Function()? onIdle,
  }) {
    return switch (this) {
      Success(data: final d) => onSuccess?.call(d as T),
      Failure(message: final m, errorData: final e) => onFailure?.call(m ?? "Unknown", e),
      Loading() => onLoading?.call(),
      Idle() => onIdle?.call(),
    };
  }

  static Future<Resource<T>> executeAndReturnResource<T>(Future<T> Function() function) async {
    try {
      var result = await function();
      return Success(data: result);
    } on ApiResponseException catch (ex) {
      return Failure(message: ex.message, errorData: ex.data);
    } on ServerException catch (e) {
      return Failure(message: e.message);
    } on NetworkException catch (e) {
      return Failure(message: e.message);
    } on BadRequestException catch (e) {
      return Failure(message: e.message);
    } on CacheException catch (e) {
      return Failure(message: e.message);
    } on Exception catch (ex) {
      return Failure(message: ex.toString());
    }
  }
}

class ApiResponseException<T> implements Exception {
  final String message;
  final String code;
  final T? data;

  ApiResponseException({required this.message, this.code = "", this.data});

  @override
  String toString() {
    return "ResponseException: $message, code: $code, data: $data";
  }
}

class Success<T> extends Resource<T> {
  Success({required T data}) : super(data: data);
}

class Loading<T> extends Resource<T> {
  Loading();
}

class Idle<T> extends Resource<T> {
  Idle();
}

class Failure<T> extends Resource<T> {
  final dynamic errorData;

  const Failure({required String message, this.errorData}) : super(message: message);
}
