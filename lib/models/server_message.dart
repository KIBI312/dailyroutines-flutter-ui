class ServerMessage {
  final String message;

  ServerMessage({required this.message});

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    return ServerMessage(message: json['description']);
  }
}
