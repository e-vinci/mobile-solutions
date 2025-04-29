import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/dish.dart';
import '../services/cart_service.dart';
import '../services/dish_service.dart';

class AppViewModel extends ChangeNotifier {
  final _dishes = <Dish>[];
  final _cart = <CartItem>[];

  AppViewModel() {
    fetchDishes().then(
      (value) {
        _dishes.addAll(value);
        notifyListeners();
      },
      onError: (error) => log(error),
    );
  }

  UnmodifiableListView<Dish> get dishes => UnmodifiableListView(_dishes);

  UnmodifiableListView<CartItem> get cart => UnmodifiableListView(_cart);

  int get total => _cart.map((item) => item.count).fold(0, (a, b) => a + b);

  double get sum => _cart.fold(0.0, (p, i) => p + i.dish.price * i.count);

  void addToCart(Dish dish) {
    final item = _cart.firstWhere((item) => item.dish == dish, orElse: () {
      final item = CartItem(dish: dish);
      _cart.add(item);
      return item;
    });
    item.count++;
    notifyListeners();
  }

  void removeFromCart(Dish dish) {
    final item = _cart.firstWhere((item) => item.dish == dish);
    if (item.count > 1) {
      item.count--;
    } else {
      _cart.remove(item);
    }
    notifyListeners();
  }

  void emptyCart() {
    _cart.clear();
    notifyListeners();
  }

  void saveCart() => save(_cart);

  Future<void> loadCart() async {
    _cart.clear();
    final loaded = await load(dishes);
    _cart.addAll(loaded);
    notifyListeners();
  }
}
