import 'package:flutter/material.dart';
import 'package:manifast_app/layout/drawer.dart';
import 'package:manifast_app/layout/menu.dart';

class ShopPage extends StatelessWidget {
  final List<FeatureCard> _featureCards = [
    FeatureCard(
      imageUrl: 'images/assets/eye_mask.jpg',
      title: 'Eye Mask',
      subtitle: 'Tap to buy on your store link.',
      price: '\$19.99',
      onTap: () {},
    ),
    FeatureCard(
      imageUrl: 'images/assets/crystals.jpg',
      title: 'Crystal Bundle',
      subtitle: 'Tap to buy on Amazon/TikTok/Shopify, etc.',
      price: '\$29.99',
      onTap: () {},
    ),
    // Add as many products as you'd like
  ];

  ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLayout(title: 'Shop'),
      drawer: Menus(),
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust crossAxisCount & aspect ratio based on screen width
            int crossAxisCount;
            double childAspectRatio;

            if (constraints.maxWidth < 600) {
              crossAxisCount = 1;
              childAspectRatio =
                  0.9; // More vertical space for single-column layout
            } else if (constraints.maxWidth < 1200) {
              crossAxisCount = 2;
              childAspectRatio = 0.8;
            } else {
              crossAxisCount = 4;
              childAspectRatio = 0.8; // Adjust as you see fit
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: _featureCards.length,
              itemBuilder: (context, index) {
                final feature = _featureCards[index];
                return _buildProductCard(
                  context,
                  imageUrl: feature.imageUrl,
                  title: feature.title,
                  subtitle: feature.subtitle,
                  price: feature.price,
                  onTap: feature.onTap,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, {
    required String imageUrl,
    required String title,
    required String subtitle,
    required String price,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use Expanded so the image can grow/shrink in the available space
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Info section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onTap;

  const FeatureCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onTap,
  });
}
