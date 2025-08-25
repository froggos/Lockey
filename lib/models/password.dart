import 'package:lockey_app/models/category.dart';

class Password {
  const Password({
    required this.id,
    required this.accountName,
    required this.password,
    this.category,
  });

  final String id;
  final String accountName;
  final String password;
  final Category? category;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountName': accountName,
      'password': password,
      if (category != null) 'category': category,
    };
  }

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(
      id: json['id'],
      accountName: json['accountName'],
      password: json['password'],
      category: json.containsKey("category")
          ? Category(
              colorCode: json['category']['colorCode'],
              name: json['category']['name'],
              id: json['category']['id'])
          : null,
    );
  }
}
