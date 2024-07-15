import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

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
      body: _groceryItems.isNotEmpty
          ? ListView.builder(
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
            )
          : const Center(
              child: Text('No items to display.'),
            ),
    );
  }
}
