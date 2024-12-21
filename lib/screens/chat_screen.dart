import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/secrects.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chatHistory = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    _model = GenerativeModel(model: 'gemini-pro', apiKey: GEMIN_API);
    _chat = _model.startChat();
    super.initState();
  }

  void getAnswer(text) async {
    if (text == null) return;
    late final response;
    var content = Content.text(text.toString());
    response = await _chat.sendMessage(content);
    setState(() {
      _chatHistory.add({
        "time": DateTime.now(),
        "message": response.text,
        "isSender": false,
        "isImage": false
      });
    });

    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Namma AI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 160,
            child: ListView.builder(
              itemCount: _chatHistory.length,
              shrinkWrap: false,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (_chatHistory[index]["isSender"]
                        ? Alignment.topRight
                        : Alignment.topLeft),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: (_chatHistory[index]["isSender"]
                            ? flutterBlue //white,
                            : white),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: _chatHistory[index]["isImage"]
                          ? Image.file(File(_chatHistory[index]["message"]),
                              width: 200)
                          : Text(_chatHistory[index]["message"],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: _chatHistory[index]["isSender"]
                                      ? white
                                      : Colors.black)),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              height: 60,
              width: double.infinity,
              color: white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                flutterBlue,
                                white,
                              ]),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                          controller: _chatController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (_chatController.text.isNotEmpty) {
                          _chatHistory.add({
                            "time": DateTime.now(),
                            "message": _chatController.text,
                            "isSender": true,
                            "isImage": false
                          });
                        }
                      });

                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );

                      getAnswer(_chatController.text);
                      _chatController.clear();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              flutterBlue,
                              white,
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.send,
                            color: white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
