import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/dish.dart';
import '../../utils/number_format.dart';
import '../../view_models/app_view_model.dart';

class DishWidget extends StatelessWidget {
  final Dish dish;

  const DishWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  onPressed: () =>
                      Provider.of<AppViewModel>(context, listen: false)
                          .addToCart(dish),
                ),
                title: Text(dish.name),
                subtitle: Text("${formatter.format(dish.price)} €"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(dish.imagePath, width: 128, height: 128),
            ),
          ],
        ),
      ),
    );
  }
}
