class ProductModel {
  String _id = '';
  String _number = '';
  String _name = '';
  String _invoiceNumber = '';
  int _price = 0;
  String _unit = '';
  String _image = '';
  int _priority = 0;
  bool _display = false;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get number => _number;
  String get name => _name;
  String get invoiceNumber => _invoiceNumber;
  int get price => _price;
  String get unit => _unit;
  String get image => _image;
  int get priority => _priority;
  bool get display => _display;
  DateTime get createdAt => _createdAt;
}
