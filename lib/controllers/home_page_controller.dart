import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/models/page_data.dart';

//nous allons dire a quoi ressemble le controller looks like
//juste une structure
//qu'est ce qu'il est capable de faire ou ses capacités
//comme une abstract class
class HomePageController extends StateNotifier<HomePageData> {
  HomePageController(super.state);
}
