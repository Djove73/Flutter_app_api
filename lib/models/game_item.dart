class GameItem {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String genre;
  final String platform;

//Constructor que obliga a inicializar todos los campos
  GameItem({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.genre,
    required this.platform,
  });

//Metodo de fabrica para crear una instancia de GameItem a partir del JSON de la request
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