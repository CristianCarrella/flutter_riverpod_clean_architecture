import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/widgets/dialogs/queued_toast_overlay.dart';

class BaseState<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppbar(), body: buildBody());
  }

  AppBar? buildAppbar() {
    return null;
  }

  Widget buildBody() {
    return QueuedToastOverlay(child: Container());
  }
}
