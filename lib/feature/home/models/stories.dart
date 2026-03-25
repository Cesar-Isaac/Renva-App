class ShowStory {
  List<Story> stories;

  ShowStory({
    required this.stories,
  });

  factory ShowStory.fromJson(List<dynamic> json) => ShowStory(
    stories: List<Story>.from(
      json.map((e) => Story.fromJson(e)),
    ),
  );

  List<Map<String, dynamic>> toJson() =>
      stories.map((e) => e.toJson()).toList();
}

class Story {
  int id;
  String providerName;
  String avatar;
  double rate;
  List<String> story;

  Story({
    required this.id,
    required this.providerName,
    required this.avatar,
    required this.rate,
    required this.story,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json['id'],
    providerName: json['provider_name'],
    avatar: json['avatar'],
    rate: (json['rate'] as num).toDouble(),
    story: List<String>.from(json['story']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'provider_name': providerName,
    'avatar': avatar,
    'rate': rate,
    'story': story,
  };
}