class GameItem {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String genre;
  final String platform;

  GameItem({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.genre,
    required this.platform,
  });

  factory GameItem.fromJson(Map<String, dynamic> json) {
    return GameItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      shortDescription: json['short_description'] ?? '',
      genre: json['genre'] ?? '',
      platform: json['platform'] ?? '',
    );
  }
}