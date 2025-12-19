import 'package:flutter/material.dart';

enum ToastType { error, info, warning, success }

class CustomToast {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final theme = _ToastTheme.fromType(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(theme.icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void error(BuildContext context, String message) =>
      show(context, message: message, type: ToastType.error);

  static void success(BuildContext context, String message) =>
      show(context, message: message, type: ToastType.success);

  static void info(BuildContext context, String message) =>
      show(context, message: message, type: ToastType.info);

  static void warning(BuildContext context, String message) =>
      show(context, message: message, type: ToastType.warning);
}

class _ToastTheme {
  final Color color;
  final IconData icon;

  _ToastTheme(this.color, this.icon);

  static _ToastTheme fromType(ToastType type) {
    switch (type) {
      case ToastType.error:
        return _ToastTheme(Colors.redAccent, Icons.error_outline);
      case ToastType.info:
        return _ToastTheme(Colors.blueAccent, Icons.info_outline);
      case ToastType.warning:
        return _ToastTheme(Colors.orangeAccent, Icons.warning_amber_rounded);
      case ToastType.success:
        return _ToastTheme(Colors.green, Icons.check_circle_outline);
    }
  }
}
