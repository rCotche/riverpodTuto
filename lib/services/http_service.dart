import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpService {
  HttpService();

  //le fait mettre un underscore avant le nom
  //d'une variable ou d'une fonction
  //cela veut dire que c'est privée
  //et donc accessible qu a l'interieur de la classe
  //propre a dart
  final _dio = Dio();

  Future<Response?> get(String path) async {
    try {
      Response res = await _dio.get(path);
      return res;
    } catch (e) {
      print(e);
    }

    return null;
  }
}
