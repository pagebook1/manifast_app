import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Home/home_controller.dart';

class Menus extends StatelessWidget {
  final controller = Get.find<HomeController>();
  Menus({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Drawer(
      child: SizedBox(
        height: double.infinity,
        child: Material(
          elevation: 8,
          child: Container(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
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
                      "Hello, Josh Doe",
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
                  onTap: () {
                    Get.toNamed('/home');
                  },
                ),
                buildMenuItem(
                  icon: Icons.auto_fix_high,
                  title: "Manifest",
                  onTap: () {
                    // controller.toggleMenu();
                    Get.toNamed('/manifest');
                  },
                ),
                buildMenuItem(
                  icon: Icons.book,
                  title: "Journal",
                  onTap: () {
                    Get.toNamed('/journal');
                  },
                ),
                buildMenuItem(
                  icon: Icons.shop,
                  title: "Shop",
                  onTap: () {
                    Get.toNamed('/shop');
                  },
                ),
                buildMenuItem(
                  icon: Icons.people,
                  title: "Referrals",
                  onTap: () {
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
                    // controller.toggleMenu();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
