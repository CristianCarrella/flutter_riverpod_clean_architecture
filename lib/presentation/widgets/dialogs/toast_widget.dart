import 'package:flutter/material.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/widgets/dialogs/queued_toast_overlay.dart';

class ToastWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onClose;
  final VoidCallback? onSlide;
  final Color backgroundColor;
  final EdgeInsets margin;
  final Duration animationDuration;
  final Duration duration;
  final ToastTransitionBuilder transitionBuilder;
  final VoidCallback onCompleted;
  final AlignmentGeometry position;

  const ToastWidget({
    super.key,
    required this.child,
    required this.onClose,
    required this.onSlide,
    required this.backgroundColor,
    required this.margin,
    required this.animationDuration,
    required this.duration,
    required this.transitionBuilder,
    required this.onCompleted,
    required this.position,
  });

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _play();
  }

  Future<void> _play() async {
    await _controller.forward();
    if (!mounted) return;

    await Future.delayed(widget.duration);
    if (!mounted) return;

    await _controller.reverse();
    if (!mounted) return;

    widget.onCompleted();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ColoredBox(
      color: widget.backgroundColor,
      child: Row(
        children: [
          Expanded(child: widget.child),
          if (widget.onClose != null)
            IconButton(onPressed: widget.onClose, icon: Icon(Icons.close)),
        ],
      ),
    );

    return Align(
      alignment: widget.position,
      child: SizedBox(
        width: double.infinity,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => widget.transitionBuilder(context, _controller, child!),
          child: Padding(
            padding: widget.margin,
            child: Material(
              child: widget.onSlide != null
                  ? Dismissible(
                      key: widget.key ?? UniqueKey(),
                      direction: DismissDirection.horizontal,
                      onDismissed: (_) => widget.onSlide?.call(),
                      child: content,
                    )
                  : content,
            ),
          ),
        ),
      ),
    );
  }
}
