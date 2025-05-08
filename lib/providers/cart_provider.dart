import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/bottle.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  void addToCart(Bottle bottle) {
    if (_items.containsKey(bottle.id)) {
      _items.update(
        bottle.id,
            (existing) => CartItem(
          id: existing.id,
          name: existing.name,
          quantity: existing.quantity + 1,
          price: existing.price,
        ),
      );
    } else {
      _items[bottle.id] = CartItem(
        id: bottle.id,
        name: bottle.name,
        quantity: 1,
        price: bottle.price,
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void increaseQuantity(String id) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
            (existing) => CartItem(
          id: existing.id,
          name: existing.name,
          quantity: existing.quantity + 1,
          price: existing.price,
        ),
      );
      notifyListeners();
    }
  }

  void decreaseQuantity(String id) {
    if (_items.containsKey(id)) {
      final current = _items[id]!;
      if (current.quantity > 1) {
        _items.update(
          id,
              (existing) => CartItem(
            id: existing.id,
            name: existing.name,
            quantity: existing.quantity - 1,
            price: existing.price,
          ),
        );
      } else {
        _items.remove(id);
      }
      notifyListeners();
    }
  }
}
