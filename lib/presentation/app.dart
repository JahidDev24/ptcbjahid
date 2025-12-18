import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptcbjahid/presentation/screens/home_screen.dart';

class DesiDimeApp extends StatelessWidget {
  const DesiDimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DesiDime Assignment',
      debugShowCheckedModeBanner: false,

      // THEME CONFIGURATION
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: false,
          // Ensures title doesn't overlap status bar in Edge-to-Edge
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
