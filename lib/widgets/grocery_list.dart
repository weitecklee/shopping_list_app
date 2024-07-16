import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/data/firebase_url.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final response = await http.get(kFirebaseUrl);

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch data. Please try again later.';
      });
      return;
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere((e) => e.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = const Center(
      child: Text('No items to display.'),
    );
    if (_isLoading) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_groceryItems.isNotEmpty) {
      body = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, i) => Dismissible(
          key: ValueKey(_groceryItems[i].id),
          onDismissed: (direction) {
            setState(() {
              _groceryItems.remove(_groceryItems[i]);
            });
          },
          child: ListTile(
            title: Text(_groceryItems[i].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[i].category.color,
            ),
            trailing: Text(_groceryItems[i].quantity.toString()),
          ),
        ),
      );
    }
    if (_error != null) {
      body = Center(
        child: Text(_error!),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: body,
    );
  }
}
