import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/article_service.dart';

class ArticleViewModel extends ChangeNotifier {
  final ArticleService service;
  List<Article> _articles;

  ArticleViewModel(this.service) : _articles = [] {
    refreshList();
  }

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  double get totalPrice => _articles.fold(
    0.0,
    (acc, article) => acc + article.count * article.price,
  );

  Future<void> refreshList() async {
    final articles = await service.getArticles();
    _articles = articles;
    notifyListeners();
  }

  Future<void> createArticle(String name, double price) async {
    await service.insertArticle(name, price);
    await refreshList();
  }

  Future<void> deleteArticle(String name) async {
    await service.deleteArticle(name);
    await refreshList();
  }

  Future<void> increaseArticle(String name) async {
    await service.increaseArticleCount(name);
    await refreshList();
  }

  Future<void> decreaseArticle(String name) async {
    await service.decreaseArticleCount(name);
    await refreshList();
  }
}
