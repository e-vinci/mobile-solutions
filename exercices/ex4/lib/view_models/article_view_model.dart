import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleViewModel extends ChangeNotifier {
  bool _showRead = false;
  final List<Article> _articles = <Article>[];

  ArticleViewModel() {
    _articles.addAll(defaultArticles);
  }

  bool get showRead => _showRead;

  List<Article> get articles => _articles;

  void toggleShowRead() {
    _showRead = !_showRead;
    notifyListeners();
  }

  Article? getArticleById(int id) =>
      _articles.firstWhere((article) => article.id == id);

  void addArticle(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  void deleteArticle(Article article) {
    _articles.remove(article);
    notifyListeners();
  }

  void toggleRead(Article article) {
    article.read = !article.read;
    notifyListeners();
  }
}
