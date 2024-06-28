import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/models/pokemon.dart';
import 'package:riverpod_example/providers/pokemon_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        return _tile(context, false, data);
      },
      error: (error, StackTrace) {
        return Text(
          "Error: $error",
        );
      },
      loading: () {
        return _tile(
          context,
          true,
          null,
        );
      },
    );
  }

  Widget _tile(
    BuildContext context,
    bool isLoading,
    Pokemon? pokemon,
  ) {
    //
    return Skeletonizer(
      //si c'est true alors show the animation
      //sinon la version "normal" (donnée charger)
      enabled: isLoading,
      child: ListTile(
        leading: pokemon != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(
                  pokemon.sprites!.frontDefault!,
                ),
              )
            : CircleAvatar(),
        title: Text(
          pokemon != null
              ? pokemon.name!.toUpperCase()
              : "currently loading the name for pokemon.",
        ),
        subtitle: Text(
          //si pokemon?.moves?.length null alors 0
          "Has ${pokemon?.moves?.length.toString() ?? 0} moves",
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}
