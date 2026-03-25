class AllCategories {
  int? id;
  String title;
  int? prvCnt;
  List<Keyword>? keywords;
  BannerImage? banner;

  AllCategories({
    this.id,
    required this.title,
    this.prvCnt,
    this.keywords,
    this.banner,
  });

  AllCategories.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] ?? '',
        prvCnt = json['prv_cnt'],
        keywords = json['keywords'] != null
            ? List<Keyword>.from(
            json['keywords'].map((x) => Keyword.fromJson(x)))
            : [],
        banner = json['banner'] != null
            ? BannerImage.fromJson(json['banner'])
            : null;


  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'prv_cnt': prvCnt,
    'keywords': keywords?.map((x) => x.toJson()).toList(),
    'banner': banner?.toJson(),
  };
}
class BannerImage {
  String originalUrl;

  BannerImage({required this.originalUrl});

  BannerImage.fromJson(Map<String, dynamic> json)
      : originalUrl = json['original_url'] ?? '';

  Map<String, dynamic> toJson() => {
    'original_url': originalUrl,
  };
}


class Keyword {
  String title;

  Keyword({
    required this.title,
  });

  Keyword.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '';

  Map<String, dynamic> toJson() => {
    'title': title,
  };
}
