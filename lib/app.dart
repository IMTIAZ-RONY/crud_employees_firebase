
import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';

class CrudApp extends StatelessWidget {
  CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor:Colors.deepPurple
        ) ,
        useMaterial3:true,
      ) ,
      home:HomeScreen() ,
    );
  }
}