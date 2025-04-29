import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'view_models/app_view_model.dart';
import 'views/screens/cart_screen.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<AppViewModel>(
    create: (context) => AppViewModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Examen blanc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: "cart",
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
