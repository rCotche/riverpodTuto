import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_example/pages/home_page.dart';
import 'package:riverpod_example/services/database_service.dart';
import 'package:riverpod_example/services/http_service.dart';

void main() async {
  //when _setupServices is completed là on va run l'app
  await _setupServices();
  runApp(const MyApp());
}

Future<void> _setupServices() async {
  //register an instance
  //on va pouvoir y avoir acces avec get_it
  GetIt.instance.registerSingleton<HttpService>(HttpService());
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //pour listen the changes ou interact avec le provider
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeDex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
          textTheme: GoogleFonts.quattrocentoSansTextTheme(),
        ),
        home: const HomePage(),
      ),
    );
  }
}
