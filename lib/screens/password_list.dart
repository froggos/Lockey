import 'package:flutter/material.dart';
import 'package:lockey_app/models/password.dart';
import 'package:lockey_app/screens/new_note.dart';
import 'package:lockey_app/widgets/main_drawer.dart';

class PasswordList extends StatefulWidget {
  const PasswordList({super.key});

  @override
  State<PasswordList> createState() => _PasswordList();
}

class _PasswordList extends State<PasswordList> {
  final List<Password> _passwordList = [];

  void _createPassword() async {
    final newPassword = await Navigator.of(context).push<Password>(
      MaterialPageRoute(
        builder: (ctx) => const NewNote(),
      ),
    );

    if (newPassword == null) return;

    setState(() {
      _passwordList.add(newPassword);
    });
  }

  void _removePassword(Password password) {
    setState(() {
      _passwordList.remove(password);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No existe ninguna contraseña.',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
    );

    if (_passwordList.isNotEmpty) {
      content = ListView.builder(
        itemCount: _passwordList.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_passwordList[index].id),
          onDismissed: (direction) {
            _removePassword(_passwordList[index]);
          },
          child: ListTile(
            title: Text(_passwordList[index].password),
            subtitle: Text(_passwordList[index].accountName),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus contraseñas'),
        actions: [
          IconButton(
            onPressed: _createPassword,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: content,
    );
  }
}
