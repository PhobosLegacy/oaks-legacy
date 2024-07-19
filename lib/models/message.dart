import 'package:oaks_legacy/utils/extensions.dart';

class Message {
  String type;
  String content;
  String date;

  Message({
    required this.type,
    required this.content,
    required this.date,
  });

  factory Message.fromDataBase(Map<String, dynamic> record) {
    return Message(
      type: record['type'],
      content: record['content'],
      date: record['created_at'].toString().formatDateTime(),
    );
  }
}
