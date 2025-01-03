import 'package:get/get.dart';
import 'package:manifast_app/Journal/journal_model.dart';

class JournalController extends GetxController {
  // Stores journal entries in a reactive list
  var journals = <JournalModel>[].obs;

  // Add a new journal entry
  void addJournal(JournalModel journal) {
    if (journal.body.trim().isNotEmpty) {
      journals.add(JournalModel(
        title: journal.title,
        body: journal.body,
        date: DateTime.now().toString(),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ));
    }
  }
}
