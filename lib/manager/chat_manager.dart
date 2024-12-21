import 'package:flutter_application_1/secrects.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatManager {
  GenerativeModel? _model;
  ChatSession? _chat;
  List<Map<String, dynamic>> chatHistory = [];

  void initialize() {
    _model = GenerativeModel(model: 'gemini-pro', apiKey: GEMIN_API);
    _chat = _model!.startChat();
  }

  void getAnswer(String text) async {
    if (text.isEmpty) return;
    var content = Content.text(text);
    final response = await _chat!.sendMessage(content);
    chatHistory.add({
      "time": DateTime.now(),
      "message": response.text,
      "isSender": true,
      "isImage": false
    });
  }
}
