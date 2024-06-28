import 'pokemon.dart';

//ça va etre le state de note homepage
//notre homepage aura un state de type HomePageData
//a l'interieur on va track pour le moment une information : data
//data est de type PokemonListData

//mais on peut ajouter autant d'information qu'on souhaite track(ex: user input)
class HomePageData {
  PokemonListData? data;

  HomePageData({
    required this.data,
  });

  /// Constructeur nommé : Dart permet d'avoir des constructeurs nommés,
  /// ce qui signifie que vous pouvez avoir plusieurs façons de créer
  /// une instance d'une classe avec différents noms pour chaque constructeur.
  ///Le constructeur par défaut initialise ces propriétés à partir des paramètres passés.
  ///Ce constructeur initialise les propriétés title et welcomeMessage avec des valeurs par défaut.

  //creat an instance of HomePageData
  //puis set dans un premier temps la property  data à null car
  //qd on construit la classe on a pas de data on va aller chercher depuis l'API
  //puis mettre a jour data

  //c'est pas une ternaire, c'est la syntaxe
  //pour avoir des valeurs specifique pour la construction de l'objet
  HomePageData.initial() : data = null;

  ///Méthode copyWith : Permet de créer une nouvelle instance de HomePageData
  ///en changeant certaines de ses propriétés.
  ///Si une propriété n'est pas spécifiée (null), elle conserve sa valeur actuelle.

  //Prendre l'instance HomePageData qui existe déjà
  //puis update avec la data qu'on reçoit
  //et enfin return une nouvelle instance de HomePageData
  HomePageData copyWith({PokemonListData? data}) {
    return HomePageData(
      data: data ?? this.data,
    );
  }
}
