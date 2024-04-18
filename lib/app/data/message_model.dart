class MessageModel {
  final String id;
  final String message;
  final String senderId;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  factory MessageModel.fromMap(String id, Map<String, dynamic> data) {
    return MessageModel(
      id: id,
      message: data['message'],
      senderId: data['senderId'],
      timestamp: DateTime.parse(data['timestamp']),
    );
  }
}

class DataMsgModel {
  final List<MessageModel> messages;

  DataMsgModel({
    required this.messages,
  });

  factory DataMsgModel.fromMap(Map<String, dynamic> data) {
    final List<MessageModel> messages = [];
    data.forEach((key, value) {
      messages.add(MessageModel.fromMap(key, Map<String, dynamic>.from(value)));
    });

    return DataMsgModel(
      messages: messages,
    );
  }
}
