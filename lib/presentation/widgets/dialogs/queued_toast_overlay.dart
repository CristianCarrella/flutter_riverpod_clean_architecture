import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/widgets/dialogs/toast_widget.dart';

class QueuedToastOverlay extends StatefulWidget {
  final Widget child;

  const QueuedToastOverlay({super.key, required this.child});

  @override
  State<QueuedToastOverlay> createState() => QueuedToastOverlayState();

  static QueuedToastOverlayState? of(BuildContext context) {
    return context.findAncestorStateOfType<QueuedToastOverlayState>();
  }
}

class QueuedToastOverlayState extends State<QueuedToastOverlay> {
  final Queue<ToastWidget> _queue = Queue();
  final ValueNotifier<Widget> _toastNotifier = ValueNotifier(const SizedBox.shrink());
  bool _isShowing = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ValueListenableBuilder(
          valueListenable: _toastNotifier,
          builder: (_, toast, widget) => toast,
        ),
      ],
    );
  }

  void showToast({
    required Widget child,
    required AlignmentGeometry position,
    required ToastTransitionBuilder transitionBuilder,
    Duration animationDuration = const Duration(seconds: 1),
    VoidCallback? onSlide,
    VoidCallback? onClose,
    Color backgroundColor = Colors.transparent,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 16),
    required Duration duration,
  }) {
    _queue.add(
      ToastWidget(
        key: UniqueKey(),
        onClose: onClose != null ? () => _showNext(animationDuration: animationDuration) : null,
        onSlide: onSlide != null ? () => _showNext(animationDuration: animationDuration) : null,
        backgroundColor: backgroundColor,
        margin: margin,
        onCompleted: () => _showNext(animationDuration: animationDuration),
        duration: duration,
        transitionBuilder: transitionBuilder,
        animationDuration: animationDuration,
        position: position,
        child: child,
      ),
    );

    if (!_isShowing) {
      _showNext(animationDuration: animationDuration);
    }
  }

  void _showNext({required Duration animationDuration}) {
    if (_queue.isEmpty) {
      _isShowing = false;
      _toastNotifier.value = const SizedBox.shrink();
      return;
    }

    _isShowing = true;
    _toastNotifier.value = _queue.removeFirst();
  }
}

typedef ToastTransitionBuilder =
    Widget Function(BuildContext context, Animation<double> animation, Widget child);
