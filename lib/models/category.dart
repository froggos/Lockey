class Category {
  Category({
    required this.colorCode,
    required this.name,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();

  final String id;
  final String colorCode;
  final String name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'colorCode': colorCode,
      'name': name,
    };
  }
}
