class User {
  final int _id;
  final String _name, _email, _phone, _website;

  User(
      {required int id,
      required String name,
      required String email,
      required String phone,
      required String website})
      : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _website = website;

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
    );
  }

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get website => _website;
}
