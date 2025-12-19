import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/app_constants.dart';

typedef TokenProvider = Future<String?> Function();

class ApiClient {
  late final Dio _dio;
  final TokenProvider? _tokenProvider;

  ApiClient({TokenProvider? tokenProvider}) : _tokenProvider = tokenProvider {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {"Content-Type": "application/json", "Accept": "application/json"},
      ),
    );

    _dio.interceptors.add(LogInterceptor());

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_tokenProvider != null) {
            final token = await _tokenProvider();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<T> _performApiCall<T>(
    Future<Response> Function() apiCall,
    T Function(dynamic json) parser,
  ) async {
    try {
      final response = await apiCall();

      if (response.data is Map || response.data is List) {
        return await compute(parser, response.data);
      } else {
        return parser(response.data);
      }
    } on DioException catch (error) {
      throw _handleDioError(error);
    } catch (error) {
      throw ApiException(message: error.toString(), code: "GENERIC");
    }
  }

  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Timeout connessione server", code: "TIMEOUT");
      case DioExceptionType.connectionError:
        return ApiException(message: "Nessuna connessione internet", code: "NO_CONNECTION");
      case DioExceptionType.badResponse:
        return _parseErrorResponse(error);
      case DioExceptionType.cancel:
        return ApiException(message: "Richiesta cancellata", code: "CANCELLED");
      default:
        return ApiException(message: "Errore sconosciuto", code: "UNKNOWN");
    }
  }

  ApiException _parseErrorResponse(DioException error) {
    final statusCode = error.response?.statusCode?.toString() ?? "500";
    final data = error.response?.data;

    String errorMessage = error.message ?? "Errore generico";

    try {
      if (data is Map<String, dynamic>) {
        if (data["content"] is Map) {
          errorMessage = data["content"]["message"] ?? errorMessage;
        } else if (data["message"] != null) {
          errorMessage = data["message"];
        }
      } else if (data is String) {
        errorMessage = data;
      }
    } catch (_) {}

    return ApiException(message: errorMessage, code: statusCode);
  }

  Future<T> get<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return _performApiCall(
      () => _dio.get(path, queryParameters: queryParameters, cancelToken: cancelToken),
      fromJson,
    );
  }

  Future<T> post<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    dynamic data,
    bool isMultipart = false,
    CancelToken? cancelToken,
  }) async {
    return _performApiCall(
      () => _dio.post(
        path,
        data: isMultipart && data is! FormData ? FormData.fromMap(data) : data,
        cancelToken: cancelToken,
        options: isMultipart ? Options(headers: {"Content-Type": "multipart/form-data"}) : null,
      ),
      fromJson,
    );
  }

  Future<T> put<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return _performApiCall(() => _dio.put(path, data: data, cancelToken: cancelToken), fromJson);
  }

  Future<T> patch<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return _performApiCall(() => _dio.patch(path, data: data, cancelToken: cancelToken), fromJson);
  }

  Future<T> delete<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return _performApiCall(() => _dio.delete(path, data: data, cancelToken: cancelToken), fromJson);
  }
}

class ApiException implements Exception {
  final String message;
  final String code;

  ApiException({required this.message, required this.code});

  @override
  String toString() => message;
}
