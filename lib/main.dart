import 'package:flutter/material.dart';
import '../screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xFF1D1E33),
          ),
          // scaffoldBackgroundColor: Colors.blueGrey[900],
          scaffoldBackgroundColor: Colors.blueGrey[900]),
      home: const LoadingScreen(),
    );
  }
}

/*
Flutter Notes:

using scaffold
home: Scaffold(body: LoadingScreen()),
To Navigate with routes:
    Navigator.pushNamed(
      context,
      '/start_screen',
      arguments: ScreenArguments(
        'Extract Arguments Screen',
        'This message is extracted in the build method.',
      ),
    );

    How to use Routes on main.dart:
initialRoute: '/',
routes: {
  '/': (context) => const LoadingScreen(),
  '/start_screen': (context) => StartScreen(),
  '/pokedex_list': (context) => ListPage(),
},

Use color from main theme
  color: Theme.of(context).backgroundColor, <-- Inside Container

*/