class Password {
  const Password({
    required this.id,
    required this.accountName,
    required this.password,
    this.groupId,
  });

  final String id;
  final String accountName;
  final String password;
  final int? groupId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountName': accountName,
      'password': password,
      if (groupId != null) 'groupId': groupId,
    };
  }

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(
      id: json['id'],
      accountName: json['accountName'],
      password: json['password'],
      groupId: json['groupId'],
    );
  }
}
