import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/base/base_consumer.dart';

import '../../core/providers/view_providers.dart';

class SerieAScreen extends BaseConsumer {
  const SerieAScreen({super.key});

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamsProvider);

    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Errore: ${state.errorMessage}'));
    }

    final teams = state.teams;

    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return ListTile(
          title: Text(team.name),
          trailing: Text('${team.points} pts'),
        );
      },
    );
  }

  @override
  AppBar? buildAppbar() {
    return AppBar(title: const Text('Serie A'));
  }
}
