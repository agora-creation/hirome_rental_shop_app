class ShopModel {
  String _id = '';
  String _number = '';
  String _name = '';
  String _invoiceName = '';
  String _password = '';
  List<String> favorites = [];
  int _priority = 0;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get number => _number;
  String get name => _name;
  String get invoiceName => _invoiceName;
  String get password => _password;
  int get priority => _priority;
  DateTime get createdAt => _createdAt;
}
