import 'package:arriverdapp/presentation/providers/auth_storage.dart';
import 'package:arriverdapp/presentation/screens/home_sceen.dart';
import 'package:arriverdapp/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MainScreen());
  }
}
