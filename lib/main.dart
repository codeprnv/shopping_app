import 'package:flutter/material.dart';
import 'package:shopping_practice_app/providers/cart_provider.dart';
import 'package:shopping_practice_app/pages/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 123, 1, 254),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            hintFadeDuration: Duration(milliseconds: 200),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            labelLarge: TextStyle(
              color: Colors.white,
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            shadowColor: Color.fromARGB(255, 214, 163, 250),
            color: Color.fromARGB(255, 111, 40, 188),
          ),
          useMaterial3: true,
        ),
        home: const Homepage(),
      ),
    );
  }
}
