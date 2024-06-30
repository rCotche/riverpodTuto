import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/providers/pokemon_data_providers.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonUrl;

  const PokemonStatsCard({
    super.key,
    required this.pokemonUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));
    return AlertDialog(
      title: const Text("Statistics"),
      content: pokemon.when(
        data: (data) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: data?.stats?.map(
                  (uneStat) {
                    return Text(
                        "${uneStat.stat?.name?.toUpperCase()}: ${uneStat.baseStat}");
                  },
                ).toList() ??
                [],
          );
        },
        error: (error, stackTrace) {
          return Text(
            "Error: $error",
          );
        },
        loading: () {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        },
      ),
    );
  }
}
