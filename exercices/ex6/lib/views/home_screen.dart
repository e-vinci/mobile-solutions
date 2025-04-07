import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_models/article_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.go("/create"),
      ),
      body: Consumer<ArticleViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: viewModel.articles.length,
                  itemBuilder: (context, index) {
                    final article = viewModel.articles[index];
                    return ListTile(
                      title: Text(article.name),
                      isThreeLine: true,
                      subtitle: Text(
                        "Unit price: ${formatCurrency.format(article.price)}\n"
                        "Total: ${formatCurrency.format(article.count * article.price)}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed:
                                () => viewModel.decreaseArticle(article.name),
                            icon: Icon(Icons.remove),
                          ),
                          Text("${article.count}"),
                          IconButton(
                            onPressed:
                                () => viewModel.increaseArticle(article.name),
                            icon: Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed:
                                () => viewModel.deleteArticle(article.name),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Total cart price: ${formatCurrency.format(viewModel.totalPrice)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
