import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/providers/events_provider.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/widgets/dialogs/custom_dialog.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/widgets/dialogs/custom_toast.dart';

import '../../core/providers/view_providers.dart';

class BaseConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppbar(), body: _buildBody());
  }

  AppBar? buildAppbar() {
    return null;
  }

  Widget _buildBody() {
    ref.listen(eventsProvider, handleEvents);
    return SafeArea(child: buildContent(context));
  }

  // You can override it if you want to handle events in other way
  void handleEvents(previous, next) {
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

  Widget buildContent(BuildContext context) {
    return Container();
  }
}
