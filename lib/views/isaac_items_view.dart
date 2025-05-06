import 'package:flutter/material.dart';
import '../viewmodels/isaac_viewmodel.dart';
import '../models/isaac_item.dart';

class IsaacItemsView extends StatefulWidget {
  const IsaacItemsView({Key? key}) : super(key: key);

  @override
  _IsaacItemsViewState createState() => _IsaacItemsViewState();
}

class _IsaacItemsViewState extends State<IsaacItemsView> {
  final IsaacViewModel _viewModel = IsaacViewModel();
  final TextEditingController _searchController = TextEditingController();
  List<IsaacItem> _filteredItems = [];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      await _viewModel.fetchItems();
      if (mounted) {
        setState(() {
          _filteredItems = _viewModel.items;
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  void _filterItems(String query) {
    if (!mounted) return;
    setState(() {
      _filteredItems = _viewModel.searchItems(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binding of Isaac Items'),
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search Items',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _filterItems,
                  ),
                ),
                Expanded(
                  child: _viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _viewModel.error != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _viewModel.error!,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: _loadItems,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            )
                          : _filteredItems.isEmpty
                              ? const Center(
                                  child: Text('No items found'),
                                )
                              : ListView.builder(
                                  itemCount: _filteredItems.length,
                                  itemBuilder: (context, index) {
                                    final item = _filteredItems[index];
                                    return Card(
                                      margin: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            item.icon,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                const Icon(Icons.error),
                                          ),
                                        ),
                                        title: Text(item.name),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '"${item.quote}"',
                                              style: const TextStyle(fontStyle: FontStyle.italic),
                                            ),
                                            Text(item.description),
                                          ],
                                        ),
                                        trailing: Chip(
                                          label: Text(item.quality),
                                          backgroundColor: _getQualityColor(item.quality),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                ),
              ],
            ),
    );
  }

  Color _getQualityColor(String quality) {
    switch (quality.toLowerCase()) {
      case 'quality 0':
        return Colors.grey;
      case 'quality 1':
        return Colors.white;
      case 'quality 2':
        return Colors.blue;
      case 'quality 3':
        return Colors.purple;
      case 'quality 4':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 