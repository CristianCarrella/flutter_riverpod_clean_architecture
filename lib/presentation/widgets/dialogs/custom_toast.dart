import 'package:flutter/material.dart';

enum DialogType { error, info, warning, success, none }

class CustomToast {
  static void show(
    BuildContext context, {
    String? message,
    DialogType type = DialogType.info,
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
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(theme.icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              if (message != null)
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
      show(context, message: message, type: DialogType.error);

  static void success(BuildContext context, String message) =>
      show(context, message: message, type: DialogType.success);

  static void info(BuildContext context, String message) =>
      show(context, message: message, type: DialogType.info);

  static void warning(BuildContext context, String message) =>
      show(context, message: message, type: DialogType.warning);
}

class _ToastTheme {
  final Color color;
  final IconData icon;

  _ToastTheme(this.color, this.icon);

  static _ToastTheme fromType(DialogType type) {
    switch (type) {
      case DialogType.error:
        return _ToastTheme(Colors.redAccent, Icons.error_outline);
      case DialogType.info:
        return _ToastTheme(Colors.blueAccent, Icons.info_outline);
      case DialogType.warning:
        return _ToastTheme(Colors.orangeAccent, Icons.warning_amber_rounded);
      case DialogType.success:
        return _ToastTheme(Colors.green, Icons.check_circle_outline);
      case DialogType.none:
        return _ToastTheme(Colors.transparent, Icons.info_outline);
    }
  }
}
