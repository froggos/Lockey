import 'package:flutter/material.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final _formKey = GlobalKey<FormState>();

  String _newPassword = 'Cb7A506a';

  bool _isCapitalChecked = true;
  bool _isLowerChecked = true;
  bool _isNumbersChecked = true;
  bool _isSpecialChecked = true;
  double _passwordLength = 15;

  void _generatePassword() {
    _newPassword = 'password';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar contraseña'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _newPassword,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Nombre de cuenta'),
                  ),
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
                    "Mayusculas (ABC)",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  value: _isCapitalChecked,
                  onChanged: (value) {
                    setState(() {
                      _isCapitalChecked = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Minusculas (abc)",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  value: _isLowerChecked,
                  onChanged: (value) {
                    setState(() {
                      _isLowerChecked = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Numeros (123)",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  value: _isNumbersChecked,
                  onChanged: (value) {
                    setState(() {
                      _isNumbersChecked = value ?? false;
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
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
