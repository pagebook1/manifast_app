import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'manifest_controller.dart';

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
