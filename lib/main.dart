import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lockey_app/screens/password_list.dart';

void main() async {
  runApp(const Lockey());
}

class Lockey extends StatelessWidget {
  const Lockey({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lockey',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const PasswordList(),
    );
  }
}
