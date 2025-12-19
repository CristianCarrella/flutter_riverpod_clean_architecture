import 'package:dio/dio.dart';

import '../logging/custom_logger.dart';

class CustomLogInterceptor extends Interceptor {
  final CustomLogger logger = CustomLogger.instance;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error != null) {
      logger.logError(data: err.error);
    } else {
      logger.logResponse(response: err.response as Response);
    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.logRequest(requestOptions: options);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.logResponse(response: response);
    handler.next(response);
  }
}
