import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifast_app/app.dart';
import 'package:manifast_app/layout/drawer.dart';
import 'package:manifast_app/layout/menu.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find();
  HomePage({super.key});

  // Menu items

  @override
  Widget build(BuildContext context) {
    // Main content is always full width
    return Scaffold(
      appBar: appBarLayout(),
      drawer: Menus(),
      body: GestureDetector(
        onTap: () {},
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
                  // Container(
                  //   width: double.infinity,
                  //   height: kToolbarHeight + 70, // some extra padding
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       colors: [
                  //         Colors.deepPurple.shade700,
                  //         Colors.deepPurple.shade400,
                  //       ],
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //     ),
                  //   ),
                  //   child: SafeArea(
                  //     child: Row(
                  //       children: [
                  //         IconButton(
                  //           icon: const Icon(Icons.menu, color: Colors.white),
                  //           onPressed: controller.toggleMenu,
                  //         ),
                  //         const Spacer(),
                  //         const Text(
                  //           "ManiFAST",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ),
                  //         const Spacer(),
                  //         const SizedBox(width: 48), // to balance the menu icon
                  //       ],
                  //     ),
                  //   ),
                  // ),

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
          ],
        ),
      ),
    );
  }
}
