import 'package:flutter/material.dart';
import 'package:homework_44/views/screens/homepage.dart';

void main(List<String> args) {
  runApp(MainRunner());
}

class MainRunner extends StatelessWidget {
  const MainRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomepageScreen());
  }
}
