import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: groceryItems.length,
        itemBuilder: (ctx, i) => Row(
          children: [
            Container(
              width: 15,
              height: 15,
              color: groceryItems[i].category.color,
            ),
            const SizedBox(width: 15),
            Text(groceryItems[i].name),
            const Spacer(),
            Text(groceryItems[i].quantity.toString()),
          ],
        ),
      ),
    );
  }
}
