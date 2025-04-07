class Article {
  final String name;
  final double price;
  int count;

  Article(this.name, this.price, this.count);
  Article.create(this.name, this.price) : count = 0;
}
