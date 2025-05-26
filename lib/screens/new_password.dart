import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lockey_app/models/password.dart';
import 'package:lockey_app/store/storage.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  String _enteredAccountName = '';

  bool _isCapitalChecked = true;
  bool _isLowerChecked = true;
  bool _isNumbersChecked = true;
  bool _isSpecialChecked = true;
  double _passwordLength = 15;

  String _generatePassword() {
    String caracteres =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+{}[]";

    if (!_isCapitalChecked) {
      caracteres = caracteres.replaceAll(RegExp(r'[A-Z]'), '');
    }

    if (!_isLowerChecked) {
      caracteres = caracteres.replaceAll(RegExp(r'[a-z]'), '');
    }

    if (!_isNumbersChecked) {
      caracteres = caracteres.replaceAll(RegExp(r'[0-9]'), '');
    }

    if (!_isSpecialChecked) {
      caracteres = caracteres.replaceAll(RegExp(r'[!@#\$%^&*()_+{}\[\]]'), '');
    }

    if (caracteres.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona al menos un tipo de caracter'),
        ),
      );

      return '';
    }

    final random = Random.secure();

    return String.fromCharCodes(Iterable.generate(_passwordLength.toInt(),
        (_) => caracteres.codeUnitAt(random.nextInt(caracteres.length))));
  }

  void _savePassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newPassword = Password(
        id: DateTime.now().toString(),
        accountName: _enteredAccountName,
        password: _passwordTextController.text,
      );

      final navigator = Navigator.of(context);

      await LockeyStorage.savePassword(newPassword);

      navigator.pop(newPassword);
    }
  }

  @override
  void initState() {
    super.initState();

    if (_passwordTextController.text.isEmpty) {
      _passwordTextController.text = _generatePassword();
    }
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Generar contraseña'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 17,
          right: 17,
          top: 17,
          bottom: bottomInset > 0 ? bottomInset + 16 : 80,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _passwordTextController,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordTextController.text = _generatePassword();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre';
                  }

                  return null;
                },
                maxLength: 50,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text(
                    'Nombre de cuenta',
                  ),
                ),
                onSaved: (value) {
                  _enteredAccountName = value!;
                },
              ),
              const SizedBox(height: 7),
              Text(
                'Longitud',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: Slider(
                  value: _passwordLength,
                  onChanged: (newLength) {
                    setState(() {
                      _passwordLength = newLength;
                      _passwordTextController.text = _generatePassword();
                    });
                  },
                  label: _passwordLength.toStringAsFixed(0),
                  min: 10,
                  max: 30,
                ),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Mayúsculas (ABC)",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                value: _isCapitalChecked,
                onChanged: (value) {
                  setState(() {
                    _isCapitalChecked = value ?? false;
                    _passwordTextController.text = _generatePassword();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Minúsculas (abc)",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                value: _isLowerChecked,
                onChanged: (value) {
                  setState(() {
                    _isLowerChecked = value ?? false;
                    _passwordTextController.text = _generatePassword();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Números (123)",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                value: _isNumbersChecked,
                onChanged: (value) {
                  setState(() {
                    _isNumbersChecked = value ?? false;
                    _passwordTextController.text = _generatePassword();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Especiales ({}[]!@#)",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                value: _isSpecialChecked,
                onChanged: (value) {
                  setState(() {
                    _isSpecialChecked = value ?? false;
                    _passwordTextController.text = _generatePassword();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: ElevatedButton(
          onPressed: _savePassword,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text('Guardar'),
        ),
      ),
    );
  }
}
