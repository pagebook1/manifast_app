import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// ----------------------------------------------------------------------
// CONTROLLERS
// ----------------------------------------------------------------------

/// Handles splash screen logic
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed('/home');
    });
  }
}

/// Handles side menu animation & user state
class HomeController extends GetxController with SingleGetTickerProviderMixin {
  // Controls whether the side menu is open
  var isMenuOpen = false.obs;

  late AnimationController menuAnimationController;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Slide from left (-1.0) to 0.0
    slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(menuAnimationController);
  }

  void toggleMenu() {
    if (isMenuOpen.value) {
      menuAnimationController.reverse();
      isMenuOpen.value = false;
    } else {
      menuAnimationController.forward();
      isMenuOpen.value = true;
    }
  }

  @override
  void dispose() {
    menuAnimationController.dispose();
    super.dispose();
  }
}

/// Manifests something; stores user input, background sound
class ManifestController extends GetxController {
  var backgroundSound = 'Meditation Bells'.obs;
  var guidedText = ''.obs;
  var manifestGoal = ''.obs;

  void setGoal(String goal) => manifestGoal.value = goal;

  void setBackgroundSound(String sound) => backgroundSound.value = sound;

  void generateGuidedVisualization() {
    final goal = manifestGoal.value.trim();
    if (goal.isEmpty) {
      guidedText.value = 'Please enter something you want to manifest.';
    } else {
      guidedText.value = 'Close your eyes. Imagine you are $goal.\n\n'
          'Now say: "I am the best $goal in the world!"\n'
          'Repeat with real enthusiasm, visualize strongly!';
    }
  }
}

// ----------------------------------------------------------------------
// MAIN APP
// ----------------------------------------------------------------------

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manifast App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashPage(),
          binding: BindingsBuilder(() {
            Get.put(SplashController());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: BindingsBuilder(() {
            Get.put(HomeController());
          }),
        ),
        GetPage(
          name: '/manifest',
          page: () => const ManifestPage(),
          binding: BindingsBuilder(() {
            Get.put(ManifestController());
          }),
        ),
        GetPage(name: '/journal', page: () => const JournalPage()),
        GetPage(name: '/shop', page: () => const ShopPage()),
        GetPage(name: '/referrals', page: () => const ReferralPage()),
      ],
    );
  }
}

// ----------------------------------------------------------------------
// SPLASH PAGE
// ----------------------------------------------------------------------
class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            SizedBox(
              width: 120,
              height: 120,
              child: Lottie.asset(
                'assets/lottie/meditation.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'MANIFAST',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Open your mind to possibilities...',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// HOME PAGE (FULL-WIDTH CONTENT + OVERLAY MENU)
// ----------------------------------------------------------------------
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
      body: Stack(
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
                  height: kToolbarHeight + 20, // some extra padding
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
                          "Manifast Home",
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
    );
  }
}

// ----------------------------------------------------------------------
// MANIFEST PAGE
// ----------------------------------------------------------------------
class ManifestPage extends GetView<ManifestController> {
  const ManifestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController manifestInputController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manifest Something"),
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
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your background sound:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                // Sound Dropdown
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.shade100,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      value: controller.backgroundSound.value,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: <String>[
                        "Meditation Bells",
                        "Nature Sounds",
                        "Tibetan Bowls",
                        "Lo-fi Beats"
                      ].map((sound) {
                        return DropdownMenuItem<String>(
                          value: sound,
                          child: Text(sound),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          controller.setBackgroundSound(val);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: manifestInputController,
                  decoration: const InputDecoration(
                    labelText: "What do you want to manifest?",
                    hintText: "e.g. Dancing better",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) => controller.setGoal(text),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.generateGuidedVisualization,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple.shade400,
                    ),
                    child: const Text("Generate Guided Visualization"),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.shade100,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    controller.guidedText.value.isNotEmpty
                        ? controller.guidedText.value
                        : "Your guided text will appear here...",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// JOURNAL PAGE
// ----------------------------------------------------------------------
class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal"),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
              child: const Text(
                "Interactive Journal (AI-based suggestions)\n\n"
                "Write about your day, the AI will analyze for patterns & synchronicities.\n\n"
                "Feature placeholder - connect your AI logic here.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// SHOP PAGE
// ----------------------------------------------------------------------
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

// ----------------------------------------------------------------------
// REFERRAL PAGE
// ----------------------------------------------------------------------
class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Referrals"),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  "Invite your friends & earn credits!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Use your referral code or QR code to invite.\n"
                  "Share your AI-generated songs or manifestation journeys "
                  "on social media with the link to this app.\n"
                  "Earn credits for each successful sign-up!",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Logic to generate or share referral link
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                  ),
                  child: const Text("Generate My Referral Link"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
