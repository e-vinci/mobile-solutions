import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item.dart';
import '../models/dish.dart';

Future<void> save(List<CartItem> cart) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  for (final item in cart) {
    await prefs.setInt(item.dish.name, item.count);
  }
}

Future<List<CartItem>> load(List<Dish> dishes) async {
  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys();

  final cart = <CartItem>[];
  for (final name in keys) {
    final dish = dishes.firstWhere((dish) => dish.name == name);
    final count = prefs.getInt(name)!;
    cart.add(CartItem(dish: dish, count: count));
  }
  return cart;
}
