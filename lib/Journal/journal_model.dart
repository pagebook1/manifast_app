class JournalModel {
  String title;
  String body;
  String date;
  String id;

  JournalModel(
      {required this.title,
      required this.body,
      required this.date,
      required this.id});

  JournalModel.fromMap(Map snapshot, this.id)
      : title = snapshot['title'] ?? '',
        body = snapshot['body'] ?? '',
        date = snapshot['date'] ?? '';

  toJson() {
    return {
      "title": title,
      "body": body,
      "date": date,
    };
  }
}
