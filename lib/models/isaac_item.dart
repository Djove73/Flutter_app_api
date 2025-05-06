class IsaacItem {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String quote;
  final String quality;

  IsaacItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.quote,
    required this.quality,
  });

  factory IsaacItem.fromJson(Map<String, dynamic> json) {
    return IsaacItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      quote: json['quote'] as String,
      quality: json['quality'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'quote': quote,
      'quality': quality,
    };
  }
} 