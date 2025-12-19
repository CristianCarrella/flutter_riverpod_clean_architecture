import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/logging/logger_provider.dart';

import '../providers/teams_provider.dart';

class SerieAScreen extends ConsumerWidget {
  const SerieAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamsProvider);

    if (state.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Serie A')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Serie A')),
        body: Center(child: Text('Errore: ${state.errorMessage}')),
      );
    }

    final teams = state.teams;

    return Scaffold(
      appBar: AppBar(title: const Text('Serie A')),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return ListTile(title: Text(team.name), trailing: Text('${team.points} pts'));
        },
      ),
    );
  }
}
