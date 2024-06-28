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
    } else {}
  }
}
