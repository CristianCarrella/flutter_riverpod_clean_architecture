// Auth provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/use_case_providers.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/events_provider.dart';
import '../../presentation/providers/teams_provider.dart';
import 'service_providers/logger_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);

  return AuthNotifier(
    loginUseCase: loginUseCase,
    logoutUseCase: logoutUseCase,
    registerUseCase: registerUseCase,
  );
});

final teamsProvider = StateNotifierProvider<TeamsNotifier, TeamsState>((ref) {
  final manageTeamsUseCase = ref.watch(manageTeamsUseCaseProvider);
  final logger = ref.watch(loggerProvider);
  return TeamsNotifier(manageTeamsUseCase: manageTeamsUseCase, logger: logger);
});

final eventsProvider = StateNotifierProvider<EventsNotifier, EventsState>((
  ref,
) {
  return EventsNotifier();
});
