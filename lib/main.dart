import 'package:flutter/material.dart';
import 'package:flutter_prac/birth_input_page.dart';

void main() {
  runApp(const PaipanApp());
}

class PaipanApp extends StatelessWidget {
  const PaipanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '命理排盘',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BirthInputPage(),
    );
  }
}
