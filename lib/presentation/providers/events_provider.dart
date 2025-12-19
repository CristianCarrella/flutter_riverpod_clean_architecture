// Auth state
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/dialogs/custom_toast.dart';

enum EventType { toast, dialog, none }

class EventsState {
  final EventType eventType;
  final String? titleMessage;
  final String? descriptionMessage;
  final DialogType dialogType;

  EventsState({
    this.eventType = EventType.none,
    this.titleMessage,
    this.descriptionMessage,
    this.dialogType = DialogType.none,
  });

  EventsState copyWith({
    EventType? eventType,
    String? titleMessage,
    String? descriptionMessage,
    DialogType? dialogType,
  }) {
    return EventsState(
      eventType: eventType ?? this.eventType,
      titleMessage: titleMessage ?? this.titleMessage,
      descriptionMessage: descriptionMessage ?? this.descriptionMessage,
      dialogType: dialogType ?? this.dialogType,
    );
  }
}

class EventsNotifier extends StateNotifier<EventsState> {
  EventsNotifier() : super(EventsState());

  void displayToast({
    required String title,
    required String description,
    DialogType type = DialogType.info,
  }) {
    state = state.copyWith(
      eventType: EventType.toast,
      titleMessage: title,
      descriptionMessage: description,
      dialogType: type,
    );
  }

  void displayDialog({
    required String title,
    required String description,
    DialogType type = DialogType.info,
  }) {
    state = state.copyWith(
      eventType: EventType.dialog,
      titleMessage: title,
      descriptionMessage: description,
      dialogType: type,
    );
  }
}
