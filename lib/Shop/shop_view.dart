import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade50,
              Colors.deepPurple.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Crystal Bundle"),
              subtitle: const Text("Tap to buy on Amazon/TikTok/Shopify, etc."),
              onTap: () {
                // Open external link or do something
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Eye Mask"),
              subtitle: const Text("Tap to buy on your store link."),
              onTap: () {
                // Open external link or do something
              },
            ),
            // Add more products...
          ],
        ),
      ),
    );
  }
}
