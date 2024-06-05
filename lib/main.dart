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
          drawerTheme: const DrawerThemeData(
            // backgroundColor: Colors.blueGrey[800],
            backgroundColor: Color(0xFF1D1E33),
          ),
          cardTheme: const CardTheme(color: Colors.red),
          // scaffoldBackgroundColor: Colors.blueGrey[900],
          scaffoldBackgroundColor: const Color(0xFF1D1E33)),
      home: const LoadingScreen(),
    );
  }
}

const styleBackgroundColor = Color(0xFF1D1E33);

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