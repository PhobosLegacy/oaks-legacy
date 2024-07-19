class News {
  String news;
  String date;

  News({
    required this.news,
    required this.date,
  });

  factory News.fromDataBase(Map<String, dynamic> record) {
    return News(
      news: record['news'],
      date: record['created_at'],
    );
  }
}
