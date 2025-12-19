import 'package:flutter/material.dart';

import 'custom_toast.dart';

class CustomDialog {
  static void show(
    BuildContext context, {
    String? title,
    String? description,
    DialogType type = DialogType.info,
    String okText = "OK",
    String? cancelText,
    VoidCallback? onOkPressed,
    VoidCallback? onCancelPressed,
    bool dismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return _CustomDialogWidget(
          title: title,
          description: description,
          type: type,
          okText: okText,
          cancelText: cancelText,
          onOkPressed: onOkPressed,
          onCancelPressed: onCancelPressed,
        );
      },
    );
  }

  static void error(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    show(
      context,
      title: title,
      description: description,
      type: DialogType.error,
    );
  }

  static void success(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    show(
      context,
      title: title,
      description: description,
      type: DialogType.success,
    );
  }
}

class _CustomDialogWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final DialogType type;
  final String okText;
  final String? cancelText;
  final VoidCallback? onOkPressed;
  final VoidCallback? onCancelPressed;

  const _CustomDialogWidget({
    required this.title,
    required this.description,
    required this.type,
    required this.okText,
    this.cancelText,
    this.onOkPressed,
    this.onCancelPressed,
  });

  Color _getColor(BuildContext context) {
    switch (type) {
      case DialogType.error:
        return Colors.redAccent;
      case DialogType.info:
        return Colors.blueAccent;
      case DialogType.warning:
        return Colors.orangeAccent;
      case DialogType.success:
        return Colors.green;
      case DialogType.none:
        return Colors.transparent;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case DialogType.error:
        return Icons.error_outline;
      case DialogType.info:
        return Icons.info_outline;
      case DialogType.warning:
        return Icons.warning_amber_rounded;
      case DialogType.success:
        return Icons.check_circle_outline;
      case DialogType.none:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = _getColor(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 16),
                if (description != null)
                  Text(
                    description!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (cancelText != null)
                      TextButton(
                        onPressed:
                            onCancelPressed ??
                            () => Navigator.of(context).pop(),
                        child: Text(
                          cancelText!,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed:
                          onOkPressed ?? () => Navigator.of(context).pop(),
                      child: Text(
                        okText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 40,
              child: Icon(_getIcon(), size: 40, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
