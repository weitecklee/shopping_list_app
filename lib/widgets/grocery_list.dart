import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(groceryItems[i].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[i].category.color,
          ),
          trailing: Text(groceryItems[i].quantity.toString()),
        ),
      ),
    );
  }
}
