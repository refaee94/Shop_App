import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem(this.id, this.title, this.quantity, this.price);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get itemsPrice {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

void removeItem(String id){
  _items.remove(id);
  notifyListeners();
}

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (value) =>
              CartItem(value.id, value.title, ++value.quantity, value.price));
    } else {
      _items.putIfAbsent(id,
          () => CartItem(DateTime.now().toIso8601String(), title, 1, price));
    }
    notifyListeners();
  }
  void clearCart(){
    _items={};
    notifyListeners();
  }
}
