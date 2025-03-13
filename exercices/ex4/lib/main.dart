import 'view_models/article_view_model.dart';
import 'package:provider/provider.dart';

import 'views/article_screen.dart';
import 'views/form_screen.dart';
import 'views/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/article.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ListScreen(),
      routes: [
        GoRoute(
          path: 'create-article',
          builder: (context, state) => const FormScreen(),
        ),
        GoRoute(
          path: 'articles/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final Article? article =
            Provider.of<ArticleViewModel>(context, listen: false)
                .getArticleById(int.parse(id));
            return ArticleScreen(article: article!);
          },
        ),
      ],
    ),
  ],
);

void main() => runApp(ChangeNotifierProvider<ArticleViewModel>(
  create: (context) => ArticleViewModel(),
  child: const MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Articles App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
