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

  static const String _imgBaseUrl = 'https://bindingofisaacrebirth.fandom.com/wiki/Special:FilePath/';

  factory IsaacItem.fromJson(Map<String, dynamic> json) {
    String iconUrl = '';
    if (json['icon'] != null && json['icon'].toString().isNotEmpty) {
      iconUrl = json['icon'].toString();
    } else if (json['img'] != null && json['img'].toString().isNotEmpty) {
      iconUrl = _imgBaseUrl + json['img'].toString().split('/').last;
    }
    return IsaacItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      icon: iconUrl,
      quote: json['quote']?.toString() ?? '',
      quality: json['quality']?.toString() ?? '',
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