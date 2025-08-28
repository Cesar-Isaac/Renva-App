
class SubCategories {
  int id;
  String title;
  dynamic svg;
  int minPrice;
  int maxPrice;
  dynamic description;
  int prvCnt;
  List<Keyword> keywords;

  SubCategories({
    required this.id,
    required this.title,
    required this.svg,
    required this.minPrice,
    required this.maxPrice,
    required this.description,
    required this.prvCnt,
    required this.keywords,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) {
    return SubCategories(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      svg: json['svg'],
      minPrice: json['minPrice'] ?? 0,
      maxPrice: json['maxPrice'] ?? 0,
      description: json['description'],
      prvCnt: json['prvCnt'] ?? 0,
      keywords:
          (json['keywords'] as List?)
              ?.map((item) => Keyword.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'svg': svg,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'description': description,
      'prvCnt': prvCnt,
      'keywords': keywords.map((k) => k.toJson()).toList(),
    };
  }
}

class Keyword {
  String title;

  Keyword({required this.title});

  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}
