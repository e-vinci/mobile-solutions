import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../../utils/number_format.dart';
import '../../view_models/app_view_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

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
                title: Text(item.dish.name),
                subtitle: Text(
                  'Unit price: ${formatter.format(item.dish.price)} €\n'
                  'Quantity: ${item.count}\n'
                  'Price : ${formatter.format(item.count * item.dish.price)} €',
                ),
                isThreeLine: true,
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () =>
                      Provider.of<AppViewModel>(context).addToCart(item.dish),
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () => Provider.of<AppViewModel>(context)
                      .removeFromCart(item.dish),
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
