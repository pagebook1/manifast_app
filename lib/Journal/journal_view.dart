import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifast_app/Journal/journal_controller.dart';
import 'package:manifast_app/layout/drawer.dart';
import 'package:manifast_app/layout/menu.dart';

import 'journal_model.dart';

/// Controller to manage the list of journals

class JournalPage extends StatelessWidget {
  JournalPage({Key? key}) : super(key: key);

  // Initialize the controller once.
  // If you already have a global binding or a parent widget providing this,
  // you can remove this line and rely on Get.find<JournalController>() instead.
  final JournalController _journalController = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLayout(title: 'My Journals'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Use Obx or GetX widget to reactively update UI when journals change
          child: Obx(
            () => _journalController.journals.isEmpty
                ? Center(
                    child: Text(
                      'No journals yet. Tap the + button to create one!',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: _journalController.journals.length,
                    itemBuilder: (context, index) {
                      final journalText = _journalController.journals[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 0,
                        ),
                        child: ListTile(
                          title: Text(journalText.body),
                          trailing: Text(DateTime.parse(journalText.date)
                              .toString()
                              .substring(0, 16)),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
      // Floating action button to add a new journal entry
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateJournalDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Displays a GetX dialog to create a new journal
  void _showCreateJournalDialog() {
    final TextEditingController _textController = TextEditingController();

    Get.defaultDialog(
      title: 'Create New Journal',
      content: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Write your journal here',
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              JournalModel content = JournalModel(
                body: _textController.text,
                title: 'My Journal',
                date: DateTime.now().toString(),
                id: DateTime.now().millisecondsSinceEpoch.toString(),
              );
              _journalController.addJournal(content);
              Get.back(); // Close the dialog
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
