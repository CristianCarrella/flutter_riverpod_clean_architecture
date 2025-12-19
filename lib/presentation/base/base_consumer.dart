import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/view_providers.dart';
import '../providers/events_provider.dart';
import '../widgets/dialogs/custom_dialog.dart';
import '../widgets/dialogs/custom_toast.dart';

class BaseConsumer extends ConsumerWidget {
  const BaseConsumer({super.key});

  AppBar? buildAppbar() {
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: buildAppbar(), body: _buildBody(context, ref));
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    ref.listen(
      eventsProvider,
      (previous, next) => handleEvents(previous, next, context),
    );
    return SafeArea(child: buildContent(context, ref));
  }

  Widget buildContent(BuildContext context, WidgetRef ref) {
    return SizedBox.shrink();
  }

  // You can override it if you want to handle events in other way
  void handleEvents(previous, next, context) {
    switch (next.eventType) {
      case EventType.toast:
        CustomToast.show(
          context,
          message: next.descriptionMessage,
          type: next.dialogType,
        );
      case EventType.dialog:
        CustomDialog.show(
          context,
          title: next.titleMessage,
          description: next.descriptionMessage,
        );
      case EventType.none:
        break;
    }
  }
}
