import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifast_app/app.dart';
import 'package:manifast_app/layout/backdrop.dart';
import 'package:manifast_app/layout/drawer.dart';
import 'package:manifast_app/layout/menu.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find();

  // Track the current page in the carousel to enable fancy scaling or indicators (if desired)
  final PageController _pageController = PageController(
    viewportFraction: 0.8, // Slightly smaller so neighbors are visible
  );
  int _currentPage = 0;

  // Data for the carousel
  final List<_FeatureCardData> _featureCards = [
    _FeatureCardData(
      title: 'Guided Meditations',
      description: 'Relax and focus your mind',
      icon: Icons.self_improvement,
    ),
    _FeatureCardData(
      title: 'Journal',
      description: 'Document your gratitude & reflections',
      icon: Icons.book,
    ),
    _FeatureCardData(
      title: 'Visualization',
      description: 'Picture your goals clearly',
      icon: Icons.visibility,
    ),
    _FeatureCardData(
      title: 'Manifestation Tips',
      description: 'Learn best practices',
      icon: Icons.lightbulb,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page ?? 0;
      setState(() {
        _currentPage = page.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Header / AppBar
      appBar:
          appBarLayout(), // Make sure this displays "ManifestNow" & profile icon
      drawer: Menus(),
      // 2. Main Content
      body: Stack(children: [
        // Background animation
        const StarryBackground(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                // [MORNING GREETING]
                Text(
                  "Good Morning, Sarah!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                const SizedBox(height: 8),

                // [DAILY AFFIRMATION BANNER]
                _buildAffirmationBanner(),
                const SizedBox(height: 16),

                // [FEATURE CAROUSEL]
                _buildFeatureCarousel(),
                const SizedBox(height: 16),

                // [PROGRESS & COMMUNITY]
                _buildProgressAndCommunity(),
                const SizedBox(height: 16),

                // [FOOTER NAV / COPYRIGHT]
                _buildFooter(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // DAILY AFFIRMATION BANNER
  Widget _buildAffirmationBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.shade100,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "DAILY AFFIRMATION",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "I am attracting prosperity with ease",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // FEATURE CAROUSEL
  Widget _buildFeatureCarousel() {
    return SizedBox(
      height: 300, // Enough height to accommodate the card design
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            // Swiping in right direction
            if (_pageController.page! > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          } else if (details.delta.dx < 0) {
            // Swiping in left direction
            if (_pageController.page! < _featureCards.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: _featureCards.length,
          itemBuilder: (context, index) {
            final feature = _featureCards[index];
            // Optional scaling effect
            final scale = (index == _currentPage) ? 1.0 : 0.9;

            return TweenAnimationBuilder(
              tween: Tween<double>(begin: scale, end: scale),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              builder: (context, double value, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Transform.scale(
                    scale: value,
                    child: _buildFeatureCard(
                      title: feature.title,
                      description: feature.description,
                      icon: feature.icon,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // SINGLE FEATURE CARD
  Widget _buildFeatureCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 8), // spacing between cards
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.shade100,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.deepPurple.shade600,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  // PROGRESS & COMMUNITY SECTION
  Widget _buildProgressAndCommunity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Example: Progress (Streak)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.shade100,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Progress & Stats",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text("You’re on a 5-day streak! Keep going!"),
                const SizedBox(height: 8),
                // Example progress bar
                LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.deepPurple.shade50,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.deepPurple.shade400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Example: Community / Inspirational Stories
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.shade100,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Community Highlights",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "“I manifested my dream job in just 3 weeks!” — Alex",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 4),
                const Text(
                  "“Daily meditation changed my life.” — Priya",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FOOTER NAV / COPYRIGHT
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // Simple horizontal nav
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Home"),
              Text("Affirmations"),
              Text("Meditations"),
              Text("Profile"),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "© 2025 ManifestNow",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// Simple data model for feature cards
class _FeatureCardData {
  final String title;
  final String description;
  final IconData icon;

  _FeatureCardData({
    required this.title,
    required this.description,
    required this.icon,
  });
}
