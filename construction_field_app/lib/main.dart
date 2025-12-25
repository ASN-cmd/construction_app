import 'package:flutter/material.dart';
import 'ui/screens/main_scaffold.dart';

void main() {
  runApp(const ConstructionApp());
}

class ConstructionApp extends StatelessWidget {
  const ConstructionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Construction Field App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainScaffold(),
    );
  }
}
