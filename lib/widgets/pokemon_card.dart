import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/models/pokemon.dart';
import 'package:riverpod_example/providers/pokemon_data_providers.dart';

class PokemonCard extends ConsumerWidget {
  final String pokemonUrl;

  //
  const PokemonCard({super.key, required this.pokemonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));

    return pokemon.when(data: (data) {
      return _card(
        context,
        false,
        data,
      );
    }, error: (error, stackTrace) {
      return Text(
        "Error: $error",
      );
    }, loading: () {
      return _card(
        context,
        true,
        null,
      );
    });
  }

  Widget _card(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.03,
        vertical: MediaQuery.sizeOf(context).height * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.03,
        vertical: MediaQuery.sizeOf(context).height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
