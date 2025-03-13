import '../view_models/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, viewModel, child) {
        var articles = [
          for (var article in viewModel.articles)
            if (viewModel.showRead || !article.read) article
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Articles"),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            actions: [
              IconButton(
                icon: viewModel.showRead
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
                onPressed: () => viewModel.toggleShowRead(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.go("/create-article"),
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: articles.isEmpty
                ? const Center(
              child: Text("There are no articles yet. Create one!"),
            )
                : ListView.separated(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var article = articles[index];
                return ListTile(
                  leading: IconButton(
                    icon: article.read
                        ? const Icon(Icons.check_box)
                        : const Icon(Icons.check_box_outline_blank),
                    onPressed: () => viewModel.toggleRead(article),
                  ),
                  title: Text(article.title),
                  subtitle: Text(article.author),
                  onTap: () => context.go('/articles/${article.id}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => viewModel.deleteArticle(article),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        );
      },
    );
  }
}
