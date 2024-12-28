import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  // Menu items
  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Main content is always full width
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          controller.isMenuOpen.value ? controller.toggleMenu() : null;
        },
        child: Stack(
          children: [
            // Main content behind the menu
            Container(
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
              child: Column(
                children: [
                  // AppBar Replacement
                  Container(
                    width: double.infinity,
                    height: kToolbarHeight + 70, // some extra padding
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade700,
                          Colors.deepPurple.shade400,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: controller.toggleMenu,
                          ),
                          const Spacer(),
                          const Text(
                            "ManiFAST",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(width: 48), // to balance the menu icon
                        ],
                      ),
                    ),
                  ),

                  // Main body content
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
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
                              Text(
                                "Welcome to Manifast!",
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.deepPurple.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "A place to visualize, journal, and bring your dreams to life.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Overlaid side menu
            Obx(
              () => AnimatedSlide(
                offset: controller.isMenuOpen.value
                    ? Offset.zero
                    : const Offset(-1.0, 0.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.65, // 65% of screen
                  height: double.infinity,
                  child: Material(
                    elevation: 8,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 60, left: 16, right: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple.shade700,
                            Colors.deepPurple.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                child: const Icon(Icons.person,
                                    size: 36, color: Colors.white),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Hello, User",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(color: Colors.white.withOpacity(0.4)),

                          // Menu items
                          buildMenuItem(
                            icon: Icons.home_filled,
                            title: "Home",
                            onTap: controller.toggleMenu,
                          ),
                          buildMenuItem(
                            icon: Icons.auto_fix_high,
                            title: "Manifest",
                            onTap: () {
                              controller.toggleMenu();
                              Get.toNamed('/manifest');
                            },
                          ),
                          buildMenuItem(
                            icon: Icons.book,
                            title: "Journal",
                            onTap: () {
                              controller.toggleMenu();
                              Get.toNamed('/journal');
                            },
                          ),
                          buildMenuItem(
                            icon: Icons.shop,
                            title: "Shop",
                            onTap: () {
                              controller.toggleMenu();
                              Get.toNamed('/shop');
                            },
                          ),
                          buildMenuItem(
                            icon: Icons.people,
                            title: "Referrals",
                            onTap: () {
                              controller.toggleMenu();
                              Get.toNamed('/referrals');
                            },
                          ),
                          const Spacer(),
                          Divider(color: Colors.white.withOpacity(0.4)),
                          buildMenuItem(
                            icon: Icons.logout,
                            title: "Logout",
                            onTap: () {
                              // handle logout
                              controller.toggleMenu();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
