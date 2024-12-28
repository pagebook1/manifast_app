import 'package:get/get.dart';

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
