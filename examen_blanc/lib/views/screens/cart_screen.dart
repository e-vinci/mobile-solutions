import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/number_format.dart';
import '../../view_models/app_view_model.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: viewModel.saveCart,
            ),
            IconButton(
              icon: const Icon(Icons.restore),
              onPressed: viewModel.loadCart,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.emptyCart,
          child: const Icon(Icons.clear_all),
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: 512,
                child: viewModel.cart.isNotEmpty
                    ? ListView.builder(
                        itemCount: viewModel.cart.length,
                        itemBuilder: (context, index) =>
                            CartItemWidget(item: viewModel.cart[index]),
                      )
                    : const Center(child: Text("Cart is empty.")),
              ),
            ),
            Center(
              child: Text(
                'Total: ${formatter.format(viewModel.sum)} €',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
