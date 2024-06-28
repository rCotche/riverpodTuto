import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/providers/pokemon_data_providers.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonUrl;
  const PokemonListTile({super.key, required this.pokemonUrl});

  @override
  //WidgetRef ref permet de consume le provider pokemonDataProvider
  Widget build(BuildContext context, WidgetRef ref) {
    //interact with le provider & rebuil widget when changes
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));

    //return ui selon si il y a une donnee
    //si il y a une erreur
    //si c'est en chargement
    return pokemon.when(
      data: (data) {
        return _tile(context);
      },
      error: (error, StackTrace) {
        return Text(
          "Error: $error",
        );
      },
      loading: () {
        return _tile(context);
      },
    );
  }

  Widget _tile(BuildContext context) {
    return ListTile(
      title: Text(
        pokemonUrl,
      ),
    );
  }
}
