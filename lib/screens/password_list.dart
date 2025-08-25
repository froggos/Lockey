import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lockey_app/models/password.dart';
import 'package:lockey_app/screens/new_password.dart';
import 'package:lockey_app/store/storage.dart';
import 'package:lockey_app/widgets/main_drawer.dart';

class PasswordList extends StatefulWidget {
  const PasswordList({super.key});

  @override
  State<PasswordList> createState() => _PasswordList();
}

class _PasswordList extends State<PasswordList> {
  final List<Password> _passwordList = [];
  List<Password> _filteredList = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _createPassword() async {
    final newPassword = await Navigator.of(context).push<Password>(
      MaterialPageRoute(
        builder: (ctx) => const NewPassword(),
      ),
    );

    if (newPassword == null) return;

    setState(() {
      _passwordList.add(newPassword);
      _filteredList = _passwordList;
    });
  }

  void _removePassword(Password password) async {
    await LockeyStorage.deletePassword(password);
    setState(() {
      _passwordList.remove(password);
      _filteredList.remove(password);
    });
  }

  Future<void> _loadData() async {
    final actualList = await LockeyStorage.getPasswords();

    setState(() {
      _passwordList.addAll(actualList);
      _filteredList = List.from(_passwordList);
    });
  }

  void _startSearching() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filteredList = _passwordList;
    });
  }

  void showPasswords() {}

  @override
  void initState() {
    super.initState();
    _loadData();
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

    if (_filteredList.isNotEmpty) {
      content = ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(
          height: 0,
        ),
        itemCount: _filteredList.length,
        itemBuilder: (ctx, index) => Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            color: const Color(0xFFB53C3C),
          ),
          key: ValueKey(_filteredList[index].id),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmar eliminacion'),
                content: Text(
                    '¿Realmente deseas eliminar ${_filteredList[index].accountName}?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'Cancelar',
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            );
          },
          onDismissed: (direction) {
            _removePassword(_filteredList[index]);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E2334),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF343D5B),
                  width: 1,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Color(_filteredList[index].category != null
                        ? _filteredList[index].category!.colorCode
                        : 0xFF3758A6),
                    width: 8,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(_filteredList[index].password),
                subtitle: Text(_filteredList[index].accountName),
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Clipboard.setData(
                      ClipboardData(text: _filteredList[index].password));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Se ha copiado la contraseña de ${_filteredList[index].accountName}'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createPassword,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _filteredList = _passwordList
                        .where((p) => p.accountName
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                autofocus: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : const Text('Tus contraseñas'),
        actions: [
          _isSearching
              ? IconButton(
                  onPressed: _stopSearching,
                  icon: const Icon(
                    Icons.close,
                  ))
              : IconButton(
                  onPressed: _startSearching,
                  icon: const Icon(Icons.search),
                ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye_outlined),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: content,
    );
  }
}
