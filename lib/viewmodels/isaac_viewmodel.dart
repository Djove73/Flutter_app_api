import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/isaac_item.dart';

class IsaacViewModel {
  List<IsaacItem> _items = [];
  bool _isLoading = false;
  String? _error;

  List<IsaacItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;

  static const String _mockJson = '''
  [
    {"name":"A Pony","id":"130","img":"item_images/a_pony.png","is_active":true,"quote":"Flight + dash attack","description":"Passively grants flight and increases speed to 1.5. Upon use, Isaac charges in the direction the pony is facing, giving invulnerability during the charge and dealing damage to enemies hit.","quality":"2"},
    {"name":"Anarchist Cookbook","id":"65","img":"item_images/anarchist_cookbook.png","is_active":true,"quote":"Summon bombs","description":"Spawns six  Troll Bombs around the room.","quality":"0"},
    {"name":"Best Friend","id":"136","img":"item_images/best_friend.png","is_active":true,"quote":"Friends 'till the end","description":"Spawns a decoy Isaac that explodes after 5 seconds. Enemies will always target the decoy and ignore Isaac.","quality":"0"},
    {"name":"Blank Card","id":"286","img":"item_images/blank_card.png","is_active":true,"quote":"Card mimic","description":"  Copies the effect of the card or rune currently held by Isaac.  Copies the effect of the card currently held by Isaac. The charge time is based on the power of the card.","quality":"2"},
    {"name":"Blood Rights","id":"186","img":"item_images/blood_rights.png","is_active":true,"quote":"Mass enemy damage at a cost","description":"Takes a full heart of health and deals 40 damage to all enemies in the room.   Repeated uses in the same room only take half a heart.","quality":"0"},
    {"name":"Bob's Rotten Head","id":"42","img":"item_images/bob's_rotten_head.png","is_active":true,"quote":"Reusable ranged bomb","description":"Isaac holds a poison Bomb which can be thrown in the cardinal directions and explodes on impact.","quality":"1"},
    {"name":"Book of Revelations","id":"78","img":"item_images/book_of_revelations.png","is_active":true,"quote":"Reusable soul protection","description":"Increases the chance of a Devil Room / Angel Room appearing while held. Upon use, gives one  Soul Heart, and replaces the boss of the current floor with a Harbinger if possible.","quality":"3"},
    {"name":"Book of Secrets","id":"287","img":"item_images/book_of_secrets.png","is_active":true,"quote":"Tome of knowledge","description":"Gives the effect of Treasure Map, The Compass, or Blue Map for the duration of the current floor.   If all effects are active,  X-Ray Vision is provided for the floor instead. Highlights any Tinted Rocks and rocks with Crawl Space in the room.","quality":"0"},
    {"name":"Book of Shadows","id":"58","img":"item_images/book_of_shadows.png","is_active":true,"quote":"Temporary invincibility","description":"Creates a protective shield, nullifying all types of damage in the current room for 10 seconds.","quality":"3"},
    {"name":"Box of Spiders","id":"288","img":"item_images/box_of_spiders.png","is_active":true,"quote":"It's a box of spiders","description":"  Spawns 1-4 Blue Spiders that deal 2.5Ã— Isaac's damage to enemies.  Spawns 4-8 Blue Spiders that deal 2Ã— Isaac's damage to enemies.","quality":"1"},
    {"name":"Breath of Life","id":"326","img":"item_images/breath_of_life.png","is_active":true,"quote":"Invincibility at a cost","description":"Grants a brief moment of invincibility when the charge bar hits zero. Isaac begins taking damage if the item is held any longer.   Isaac creates beams of light when touching enemies while invulnerable, and creates a powerful 4-way beam if blocking damage exactly as the invincibility starts.","quality":"1"},
    {"name":"Butter Bean","id":"294","img":"item_images/butter_bean.png","is_active":true,"quote":"Reusable knock-back","description":"Isaac farts and knocks back nearby enemies   and projectiles.   Enemies pushed into walls or obstacles take 12 damage.","quality":"0"},
    {"name":"Converter","id":"296","img":"item_images/converter.png","is_active":true,"quote":"Convert your soul","description":"  Converts two  Soul Hearts or  Black Hearts into one filled  Red Heart Container.  Converts one  Soul Heart or  Black Heart into one filled  Red Heart Container.","quality":"1"},
    {"name":"Crack the Sky","id":"160","img":"item_images/crack_the_sky.png","is_active":true,"quote":"Holy white death","description":"Summons 5 beams of light in random locations on the ground, dealing large amounts of damage to any enemies that touch them.","quality":"1"},
    {"name":"Crystal Ball","id":"158","img":"item_images/crystal_ball.png","is_active":true,"quote":"I see my future","description":"Reveals the map (except the Super Secret Room and Ultra Secret Room) and drops a  Soul Heart or random card/rune.   While held, increases the chance of finding a Planetarium.","quality":"3"},
    {"name":"D10","id":"285","img":"item_images/d10.png","is_active":true,"quote":"Reroll enemies","description":"  Re-rolls all monsters in the room.  Replaces all monsters in the room with weaker monsters.","quality":"1"}
  ]
  ''';

  Future<void> fetchItems() async {
    _isLoading = true;
    _error = null;
    try {
      final response = await http.get(Uri.parse('https://gist.githubusercontent.com/Djove73/3b41d6025ff2fb233c3e6fb5b8afd4c3/raw/803e4a2bf3870aac2d8c49077eca8c4fd397ff5a/isaac_items_mock.json'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _items = data.map((json) => IsaacItem.fromJson(json)).toList();
      } else {
        _error = 'Error al obtener datos de la API: Código ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
    }
  }

  Future<IsaacItem?> fetchItemById(String id) async {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      _error = 'Error fetching item: $e';
      return null;
    }
  }

  List<IsaacItem> searchItems(String query) {
    if (query.isEmpty) return _items;
    return _items.where((item) =>
      item.name.toLowerCase().contains(query.toLowerCase()) ||
      item.description.toLowerCase().contains(query.toLowerCase()) ||
      item.quote.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
} 