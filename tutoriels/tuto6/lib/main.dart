import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'services/post_service.dart';
import 'view_models/post_view_model.dart';
import 'view_models/theme_view_model.dart';
import 'views/new_post.dart';
import 'views/post_details.dart';
import 'views/post_list.dart';
import 'views/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseProvider = PostService();
  await databaseProvider.initDatabase();
  runApp(MyApp(postService: databaseProvider));
}

class MyApp extends StatelessWidget {
  final PostService postService;

  const MyApp({super.key, required this.postService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostViewModel>(
          create: (context) => PostViewModel(postService),
        ),
        ChangeNotifierProvider<ThemeViewModel>(
          create: (context) => ThemeViewModel(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => PostList(),
              routes: [
                GoRoute(
                  path: 'new_post',
                  builder: (context, state) => NewPost(),
                ),
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => Settings(),
                ),
                GoRoute(
                  path: 'posts/:id',
                  builder:
                      (context, state) =>
                          PostDetails(postId: state.pathParameters['id'] ?? ''),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
