import 'package:flutter/material.dart';
import 'package:lockey_app/screens/new_note.dart';
import 'package:lockey_app/widgets/main_drawer.dart';

class PasswordList extends StatefulWidget {
  const PasswordList({super.key});

  @override
  State<PasswordList> createState() => _PasswordList();
}

class _PasswordList extends State<PasswordList> {
  void _createPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewNote(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus claves'),
        actions: [
          IconButton(
            onPressed: _createPassword,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
