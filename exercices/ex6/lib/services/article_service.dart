import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/article.dart';

class ArticleService {
  late Database _database;

  Database get database => _database;

  Future<List<Article>> getArticles() async {
    final result = await _database.query("articles");
    return result
        .map(
          (elem) => Article(
            elem["name"] as String,
            elem["price"] as double,
            elem["count"] as int,
          ),
        )
        .toList();
  }

  Future<void> insertArticle(String name, double price) async {
    await _database.insert("articles", {
      "name": name,
      "price": price,
      "count": 0,
    });
  }

  Future<void> increaseArticleCount(String name) async {
    final result = await _database.query(
      "articles",
      where: "name = ?",
      whereArgs: [name],
    );
    final int count = result[0]["count"] as int;
    await _database.update(
      "articles",
      {"count": count + 1},
      where: "name = ?",
      whereArgs: [name],
    );
  }

  Future<void> decreaseArticleCount(String name) async {
    final result = await _database.query(
      "articles",
      where: "name = ?",
      whereArgs: [name],
    );
    final int count = result[0]["count"] as int;
    await _database.update(
      "articles",
      {"count": count - 1},
      where: "name = ?",
      whereArgs: [name],
    );
  }

  Future<void> deleteArticle(String name) async {
    await _database.delete("articles", where: "name = ?", whereArgs: [name]);
  }

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'test.db'),
      version: 1,
    );

    final result = await _database.rawQuery(
      "SELECT count(*) AS count FROM sqlite_master WHERE type='table' AND name='articles'",
    );

    if (result[0]["count"] == 0) {
      await _database.execute(
        'CREATE TABLE articles(name TEXT PRIMARY KEY, price REAL, count INTEGER DEFAULT 0)',
      );
    }
  }
}
