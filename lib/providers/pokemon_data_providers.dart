import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_example/models/pokemon.dart';
import 'package:riverpod_example/services/http_service.dart';

//ICI c'est qd on besoin de performing and caching asynchronous operations (such as network requests)
//on utilise un API

//to construct a FutureProvider from a particular argument
//that we pass on peut utiliser FutureProvider.family
//c'est un autre constructeur

//return a Pokemon, String c'est ce qu'on va passé when we are constructing it
//arg url correspond au type String de family<Pokemon?, String>
final pokemonDataProvider =
    FutureProvider.family<Pokemon?, String>((ref, url) async {
  HttpService _httpService = GetIt.instance.get<HttpService>();
  Response? res = await _httpService.get(url);
  if (res != null && res.data != null) {
    //un constructeur de la classe Pokemon
    //qui prend en argument un json et return une instance de la calsse
    return Pokemon.fromJson(res.data!);
  }

  return null;
});
