class CartModel {
  String id = '';
  String number = '';
  String name = '';
  String invoiceNumber = '';
  int price = 0;
  String unit = '';
  int requestQuantity = 0;
  int deliveryQuantity = 0;

  CartModel.fromMap(Map map) {
    id = map['id'] ?? '';
    number = map['number'] ?? '';
    name = map['name'] ?? '';
    invoiceNumber = map['invoiceNumber'] ?? '';
    price = map['price'] ?? 0;
    unit = map['unit'] ?? '';
    requestQuantity = map['requestQuantity'] ?? 0;
    deliveryQuantity = map['deliveryQuantity'] ?? 0;
  }

  Map toMap() => {
        'id': id,
        'number': number,
        'name': name,
        'invoiceNumber': invoiceNumber,
        'price': price,
        'unit': unit,
        'requestQuantity': requestQuantity,
        'deliveryQuantity': deliveryQuantity,
      };
}
