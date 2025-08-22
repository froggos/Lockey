import 'dart:convert';
import 'dart:io';

import 'package:lockey_app/models/password.dart';
import 'package:path_provider/path_provider.dart';

class LockeyStorage {
  static Future<File> _getCategoriesFile() async {
    final dir = await getApplicationCacheDirectory();
    return File('${dir.path}/lockey-categories.json');
  }

  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/lockey-storage.json');
  }

  static Future<List<Password>> getPasswords() async {
    final file = await _getFile();

    if (await file.exists()) {
      final content = await file.readAsString();
      final data = jsonDecode(content) as List;
      return data.map((password) => Password.fromJson(password)).toList();
    }

    return [];
  }

  static Future<void> savePassword(Password password) async {
    final passwords = await getPasswords();
    passwords.add(password);
    final file = await _getFile();
    final jsonList = passwords.map((password) => password.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  static Future<void> deletePassword(Password password) async {
    final passwords = await getPasswords();
    final updated = passwords.where((p) => p.id != password.id).toList();
    final file = await _getFile();
    await file.writeAsString(jsonEncode(updated));
  }

  static Future<void> getCategories() async {
    final file = await _getCategoriesFile();

    if (await file.exists()) {
      final content = await file.readAsString();
      final data = jsonDecode(content) as List;
    }
  }
}
