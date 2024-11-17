import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/main_scaffold.dart';
import 'screens/details_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainScaffold(),
        '/details': (context) => DetailsScreen(),
      },
    );
  }
}
