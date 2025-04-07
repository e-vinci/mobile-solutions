import 'package:ex6/services/article_service.dart';
import 'package:ex6/view_models/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'views/create_screen.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ArticleService service = ArticleService();
  await service.initDatabase();
  runApp(
    ChangeNotifierProvider<ArticleViewModel>(
      create: (context) => ArticleViewModel(service),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: "/",
            builder: (context, child) => HomeScreen(),
            routes: [
              GoRoute(
                path: "create",
                builder: (context, child) => CreateScreen(),
              ),
            ],
          ),
        ],
        initialLocation: "/",
      ),
    );
  }
}
