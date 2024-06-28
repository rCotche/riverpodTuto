import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/controllers/home_page_controller.dart';
import 'package:riverpod_example/models/page_data.dart';

//extends ConsumerStatefulWidget car de base on etait dans un StatefulWidget
//mais si on veut consume un provider dans un StatelessWidget
//on utilisera le widget consumer

//StateNotifierProvider a besoin qu'on lui fourni une classe qui extends de StateNotifier
//StateNotifier a besoin d'un state lors de la construction
//le state fourni est un state de type HomePageData

//HomePageData est une classe normal

//HomePageControllerProvider est le 1er provider creer
//HomePageController est le type de state notifier
//HomePageData est le type de state

//ref: widget reference
final HomePageControllerProvider =
    StateNotifierProvider<HomePageController, HomePageData>((ref) {
  //fonctionne car HomePageController extends de StateNotifier
  //parce que on construct HomePageController on doit donner un state
  //et le state initial vient de HomePageData.initial()
  return HomePageController(HomePageData.initial());
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomePageController _homePageController;
  late HomePageData _homePageData;

  @override
  Widget build(BuildContext context) {
    //Sans ProviderScope on ne peut pas utiliser ces méthodes

    //to read or interact with the providers

    //read methods just read the information for u
    //mais ne notifie pas lorsque il y a un changement
    //donc pas de re render le widget

    //watch mm chose sauf qu'il va me notifier et rebuild le widget lors d'un changement

    //notifier return HomePageController instance
    _homePageController = ref.watch(HomePageControllerProvider.notifier);
    _homePageData = ref.watch(HomePageControllerProvider);

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
