import "dart:async";
import "dart:convert";
import "dart:developer";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

class CustomLogger {
  final _reset = "\x1B[0m";
  final _red = "\x1B[31m";
  final _green = "\x1B[32m";
  final _yellow = "\x1B[33m";
  final _white = "\x1B[37m";
  final _magenta = "\x1B[35m";
  static final CustomLogger instance = CustomLogger._internal();

  factory CustomLogger() {
    return instance;
  }

  CustomLogger._internal();

  String _truncateString(String input, {int maxChars = 500}) {
    if (input.length <= maxChars) {
      return input;
    }
    return "${input.substring(0, maxChars)}\n... [truncated ${input.length - maxChars} more characters]";
  }

  Future<void> logRequest({required RequestOptions requestOptions}) async {
    final now = DateTime.now();
    final path = "${requestOptions.baseUrl}${requestOptions.path}";

    final lines = <String>[];
    lines.add("$_yellow⏳ (${requestOptions.method}) REQUEST: $path");
    lines.add("$_yellow⏳ |-> SENT AT: $now");

    if (requestOptions.headers.isNotEmpty) {
      lines.add("$_yellow⏳ |-> HEADERS: ${requestOptions.headers}");
    }
    if (requestOptions.queryParameters.isNotEmpty) {
      lines.add(
        "$_yellow⏳ |-> QUERY PARAMETERS: ${requestOptions.queryParameters}",
      );
    }
    if (requestOptions.data != null) {
      try {
        lines.add(
          "$_yellow⏳ |-> REQUEST BODY: ${jsonEncode(requestOptions.data)}",
        );
      } catch (e) {
        lines.add("$_yellow⏳ |-> REQUEST BODY: ${requestOptions.data}");
      }
    }

    log(lines.join("\n"));
  }

  String _truncateContent(
    dynamic data, {
    int maxChars = 500,
    int maxBytes = 20,
  }) {
    if (data == null) return "null";

    if (data is List<int>) {
      final length = data.length;
      final preview = data.take(maxBytes).toList();
      return '[${preview.join(', ')}${length > maxBytes ? ', ... (${length - maxBytes} more bytes)' : ''}]';
    }

    return _truncateString(data.toString(), maxChars: maxChars);
  }

  Future<void> logResponse({required Response response}) async {
    final requestOptions = response.requestOptions;
    final now = DateTime.now();
    final path = "${requestOptions.baseUrl}${requestOptions.path}";
    final status = response.statusCode ?? 500;
    final method = requestOptions.method;

    final lines = <String>[];

    final responseData = _truncateContent(response.data);

    if (status < 200 || status >= 300) {
      lines.add("$_red⛔ ($method) REQUEST FAILURE: $path");
      lines.add("$_red⛔ |-> FAILED AT: $now");
      lines.add("$_red⛔ |-> STATUS CODE: $status");
      lines.add("$_red⛔ |-> RESPONSE: $responseData");
    } else {
      lines.add("$_green✅ ($method) REQUEST SUCCESS: $path");
      lines.add("$_green✅ |-> SUCCESS AT: $now");
      lines.add("$_green✅ |-> STATUS CODE: $status");
      lines.add("$_green✅ |-> RESPONSE: $responseData");
    }

    log(lines.join("\n") + _reset);
  }

  void logError({required dynamic data}) {
    final now = DateTime.now();
    log("$_red❌ ERROR AT: $now\n$_red❌ MESSAGE: $data$_reset");
  }

  void logWarning({required dynamic data}) {
    log("$_magenta🟣 WARNING: $data$_reset");
  }

  void simpleLog({required dynamic data}) {
    log("$_white📄 LOGGING: $data$_reset");
  }
}

void executeInProduction(Future<void> Function() action) {
  if (kDebugMode) return;
  action();
}
