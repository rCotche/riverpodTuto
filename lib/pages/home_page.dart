import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/controllers/home_page_controller.dart';
import 'package:riverpod_example/models/page_data.dart';

//StateNotifierProvider a besoin qu'on lui fourni une classe qui extends de StateNotifier
//StateNotifier a besoin d'un state lors de la construction
//le state fourni est un state de type HomePageData

//HomePageData est une classe normal

//ref: widget reference
final HomePageControllerProvider = StateNotifierProvider((ref) {
  //fonctionne car HomePageController extends de StateNotifier
  //parce que on construct HomePageController on doit donner un state
  //et le state initial vient de HomePageData.initial()
  return HomePageController(HomePageData.initial());
});

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUi(
        context,
      ),
    );
  }

  //ui principal
  Widget _buildUi(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          //width of the actual device
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.sizeOf(context).width * 0.02, //2% du width du device
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _allPokemonsList(context),
            ],
          ),
        ),
      ),
    );
  }

  //pokemon list
  Widget _allPokemonsList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "All Pokemons",
            style: TextStyle(
              fontSize: 25,
            ),
          ),

          //60% de la hauteur de l'écran
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.60,
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) {
                return ListTile();
              },
            ),
          )
        ],
      ),
    );
  }
}
