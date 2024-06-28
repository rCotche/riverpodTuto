import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_example/models/page_data.dart';
import 'package:riverpod_example/models/pokemon.dart';
import 'package:riverpod_example/services/http_service.dart';

//nous allons dire a quoi ressemble le controller looks like
//juste une structure
//qu'est ce qu'il est capable de faire ou ses capacités
//comme une abstract class
class HomePageController extends StateNotifier<HomePageData> {
  //to access HttpService class
  final GetIt _getIt = GetIt.instance;
  late HttpService _httpService;

  HomePageController(super.state) {
    //initialize la variable _httpService
    //avec l'instance HttpService registred avec get_it
    _httpService = _getIt.get<HttpService>();

    _setup();
  }

  Future<void> _setup() async {
    loadData();
  }

  Future<void> loadData() async {
    //state est de type HomePageData, c'est une instance de la classe
    //if the first time we getting data
    if (state.data == null) {
      Response? res = await _httpService
          .get("https://pokeapi.co/api/v2/pokemon?limit=20&offset=0");
      //res c'est la reponse de l'api
      //res.data le json
      if (res != null && res.data != null) {
        //fromJson utility factory constructor method
        //Prend un json et return une instance de PokemonListData classe

        //donc c'est un constructeur de la classe PokemonListData
        PokemonListData data = PokemonListData.fromJson(res.data);

        //return une nouvelle instance de HomePageData class
        //du coup l'etat sera updated
        state = state.copyWith(data: data);

        //error sans le ? : The property 'results' can't be unconditionally accessed
        //because the receiver can be 'null'.
        if (kDebugMode) {
          print(state.data?.results?.first);
        }
      }
    } else {
      //si il ya un next url
      if (state.data?.next != null) {
        Response? res = await _httpService.get(state.data!.next!);
        if (res != null && res.data != null) {
          PokemonListData data = PokemonListData.fromJson(res.data);

          //method from HomePageData
          state = state.copyWith(
              //method from PokemonListData
              data: data.copyWith(results: [
            //Ce code Dart utilise l'opérateur de propagation (spread operator)
            //pour combiner des listes en un seul endroit dans une nouvelle liste.

            //...: L'opérateur de propagation.
            //Il prend une liste et "étale" ses éléments dans une nouvelle liste.

            //?: L'opérateur de null-aware.
            //Il permet de propager les éléments d'une liste seulement
            //si cette liste n'est pas nulle.
            //Si la liste est nulle, l'opérateur de propagation ne fait rien.

            //Donc, ...?state.data?.results
            //signifie "si state.data n'est pas nul, et si state.data.results n'est pas nul,
            //étale les éléments de state.data.results dans la nouvelle liste".
            //De même pour ...?data.results.

            //Le code [...?state.data?.results, ...?data.results]
            //combine les éléments de state.data.results et data.results
            //dans une nouvelle liste. Si l'une de ces listes est nulle,
            //elle est simplement ignorée.

            //the data we already have
            ...?state.data?.results,
            ...?data.results,
          ]));
        }
      }
    }
  }
}
