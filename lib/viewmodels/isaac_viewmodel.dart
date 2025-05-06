import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/isaac_item.dart';

class IsaacViewModel {
  static const String baseUrl = 'https://isaac-fastapi.onrender.com';
  List<IsaacItem> _items = [];
  bool _isLoading = false;
  String? _error;

  List<IsaacItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchItems() async {
    _isLoading = true;
    _error = null;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('The request timed out. Please try again.');
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _items = data.take(20).map((json) => IsaacItem.fromJson(json)).toList();
      } else {
        _error = 'Failed to load items: ${response.statusCode}';
      }
    } on TimeoutException {
      _error = 'The request timed out. Please try again.';
    } catch (e) {
      _error = 'Error fetching items: $e';
    } finally {
      _isLoading = false;
    }
  }

  Future<IsaacItem?> fetchItemById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items/$id'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('The request timed out. Please try again.');
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return IsaacItem.fromJson(data);
      }
      return null;
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