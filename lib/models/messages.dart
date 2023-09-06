// ignore_for_file: non_constant_identifier_names

class Messages {
  final String message;
  final String id;
  Messages({
    required this.message,
    required this.id,
  });
  factory Messages.fromJson(JsonData) {
    return Messages(
      message: JsonData["message"],
      id: JsonData['id'],
    );
  }
}
